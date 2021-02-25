const request = require('request-promise');
const fs = require('fs');

const promises = [
  // first group
  request({ url: 'https://www.pittdayofgiving.com/microsite/api/campaigns?&section_id=600b051868d93b00469b87bc', json: true }),

  // second group
  request({ url: 'https://www.pittdayofgiving.com/microsite/api/campaigns?&section_id=600b051868d93b00469b87bc&page=2', json: true }),

  // third group
  request({ url: 'https://www.pittdayofgiving.com/microsite/api/campaigns?&section_id=600b051868d93b00469b87bc&page=3', json: true })
];

Promise.all(promises)
  .then((campaignGroups) => {
    const combined = campaignGroups.map((group) => group.campaigns).flat();
    const date = (new Date()).toJSON();

    const parsed = combined.map((campaign) => {
      return {
        "Organization": campaign.name,
        "Average Donations": campaign.average_donation,
        "Total Amount Raised": campaign.total_raised_family,
        "Total Donations": campaign.total_donations,
        "Total Supporters": campaign.total_supporters
      };
    });
    fs.writeFileSync(`./pdog-parsed-${date}.json`, JSON.stringify(parsed));

    const giftsPerDonorParsed = combined.map((campaign) => {
      return {
        "Organization": campaign.name,
        "Average Number of Gifts per Donor": (campaign.total_donations / campaign.total_supporters)
      };
    });
    fs.writeFileSync(`./pdog-giftsperdonor-parsed-${date}.json`, JSON.stringify(giftsPerDonorParsed));
  });
