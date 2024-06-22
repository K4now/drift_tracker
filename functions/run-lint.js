const {exec} = require('child_process');
const path = require('path');

const eslintPath = path.resolve(__dirname, 'node_modules', '.bin', 'eslint');

exec(`${eslintPath} .`, (err, stdout, stderr) => {
  if (err) {
    console.error(`Error: ${stderr}`);
    process.exit(1);
  } else {
    console.log(stdout);
  }
});
