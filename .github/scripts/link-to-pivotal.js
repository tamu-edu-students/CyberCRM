const axios = require('axios');
const exec = require('child_process').execSync;

const pivotalApiToken = process.env.PIVOTAL_API_TOKEN;
const commitMessages = exec('git log -1 --pretty=format:%s').toString().trim();

const pivotalStoryPattern = /#(\d+)/g;
let match;
while ((match = pivotalStoryPattern.exec(commitMessages)) !== null) {
  const storyId = match[1];
  const url = `https://www.pivotaltracker.com/services/v5/stories/${storyId}`;
  const data = {
    comment: {
      text: `Commit linked: ${commitMessages}`
    }
  };

  axios({
    method: 'post',
    url: url,
    headers: {
      'X-TrackerToken': pivotalApiToken,
      'Content-Type': 'application/json'
    },
    data: data
  })
  .then(response => {
    console.log(`Linked commit to Pivotal Tracker story ${storyId}`);
  })
  .catch(error => {
    console.error(`Error linking commit to Pivotal Tracker story ${storyId}: ${error.message}`);
  });
}
