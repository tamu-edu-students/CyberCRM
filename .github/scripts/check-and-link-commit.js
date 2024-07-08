const axios = require('axios');
const { execSync } = require('child_process');

// Retrieve the Pivotal API token from environment variables
const pivotalApiToken = process.env.PIVOTAL_API_TOKEN;

// Get the commit messages
const commitMessages = execSync('git log --format=%B -n 1').toString().trim().split('\n');

// Check each commit message and process valid ones
const pivotalStoryPattern = /(?:finishes|fixes|delivers) #(\d+)/g;

commitMessages.forEach(message => {
  if (!message) {
    console.log("Empty commit message detected, likely a merge commit. Skipping.");
    return;
  }

  if (!message.match(/^#none|^\d+/) && !message.startsWith('Merge')) {
    console.log(`Invalid commit message detected: ${message}. Skipping.`);
    return;
  }

  // Process valid commit messages
  if (message.match(pivotalStoryPattern)) {
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
  } else {
    console.log(`Valid commit message but no Pivotal Tracker story ID found: ${message}`);
  }
});

console.log("Processing complete.");
