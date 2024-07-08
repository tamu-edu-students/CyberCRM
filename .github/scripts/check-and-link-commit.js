const axios = require('axios');
const { execSync } = require('child_process');

// Retrieve the Pivotal API token from environment variables
const pivotalApiToken = process.env.PIVOTAL_API_TOKEN;

// Get the commit messages
const commitMessages = execSync('git log --format=%B -n 1').toString().trim().split('\n');

// Check each commit message
let allMessagesValid = true;
commitMessages.forEach(message => {
  if (!message) {
    console.log("Empty commit message detected, likely a merge commit. Skipping.");
    return;
  }

  if (!message.match(/^#none|^\d+/) && !message.startsWith('Merge')) {
    console.error(`Commit message must start with #none, a Pivotal Tracker ID, or be a merge commit.`);
    console.error(`Invalid commit message: ${message}`);
    allMessagesValid = false;
  }
});

if (!allMessagesValid) {
  console.error("You can fix this by either linking your commit to pivotal tracker if it is relevant or following the instructions below.");
  console.error("If this is not related to pivotal tracker you can ignore");
  console.error("Some commit messages are invalid. Please fix the commit messages using the following command:");
  console.error("git rebase -i HEAD~<number_of_commits>");
  console.error("In the interactive rebase editor, change pick to reword or edit for the commits you need to modify. Save and exit the editor.");
  console.error("Git will prompt you to edit the commit messages one by one. Update them to meet the required format.");
  console.error("After fixing, you can force push the changes using:");
  console.error("git push --force-with-lease");
  process.exit(1);
}

// Process commit messages to link to Pivotal Tracker stories
const pivotalStoryPattern = /(?:finishes|fixes|delivers) #(\d+)/g;
commitMessages.forEach(message => {
  if (!message || message.startsWith('#none') || message.startsWith('Merge')) {
    console.log(`Commit message starts with #none, is empty, or is a merge commit, skipping linking: ${message}`);
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
