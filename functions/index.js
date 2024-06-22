const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports
    .scheduledUpdateLeaderboard = functions.pubsub
        .schedule('every 5 minutes')
        .onRun(async (context) => {
          try {
            const db = admin.firestore();
            const leaderboardRef = db.collection('leaderboard');

            // Fetch all sessions
            const sessionsSnapshot = await db.collection('sessions').get();
            const sessions = sessionsSnapshot.docs.map((doc) => doc.data());

            if (sessions.length === 0) {
              console.log('No sessions found.');
              return;
            }

            console.log(`Found ${sessions.length} sessions.`);

            // Initialize leaderboard
            const leaderboard = {};

            // Populate leaderboard with the highest score per user
            sessions.forEach((session) => {
              if (!leaderboard[session.userId] ||
          leaderboard[session.userId].score < session.points) {
                leaderboard[session.userId] = {
                  userId: session.userId,
                  carModel: session.carModel,
                  score: session.points,
                  date: session.date,
                };
              }
            });

            console.log('Leaderboard calculated:', leaderboard);

            // Use a batch to update the leaderboard collection
            const batch = db.batch();
            Object.values(leaderboard).forEach((entry) => {
              const entryRef = leaderboardRef.doc(entry.userId);
              batch.set(entryRef, entry);
            });

            // Commit the batch
            await batch.commit();

            console.log('Leaderboard successfully updated.');
          } catch (error) {
            console.error('Error updating leaderboard:', error);
          }
        });
