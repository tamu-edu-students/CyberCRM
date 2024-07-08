const axios = require('axios');
const { execSync } = require('child_process');

// Retrieve the Pivotal API token from environment variables
const pivotalApiToken = process.env.PIVOTAL_API_TOKEN;

// Get the commit messages
const commitMessages = execSync('git log --format=%B -n 1').toString().trim().split('\n');

// Check each commit message
commitMessages.forEach(message => {
  if (!message.match(/^#none|^\d+/) && !message.startsWith('Merge')) {
    console.error(`Commit message must start with #none, a Pivotal Tracker ID, or be a merge commit.`);
    console.error(`Invalid commit message: ${message}`);
    process.exit(1);
  }
});

// Process commit messages to link to Pivotal Tracker stories
const pivotalStoryPattern = /#(\d+)/g;
commitMessages.forEach(message => {
  if (message.startsWith('#none') || message.startsWith('Merge')) {
    console.log(`Commit message starts with #none or is a merge commit, skipping linking: ${message}`);
    return;
  }
  let match;
  while ((match = pivotalStoryPattern.exec(message)) !== null) {
    const storyId = match[1];
    const url = `https://www.pivotaltracker.com/services/v5/stories/${storyId}`;
    const data = {
      comment: {
        text: `Commit linked: ${message}`
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
});

console.log("All commit messages are valid and processed for Pivotal Tracker.");
