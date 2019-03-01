const request = require('request-promise');
const fs = require('fs');

const promises = [
  // top
  request({ url: 'https://www.pittdayofgiving.com/microsite/api/campaigns?&section_id=5bf315b92eb7ad001d6db293', json: true }),

  // bottom
  request({ url: 'https://www.pittdayofgiving.com/microsite/api/campaigns?&section_id=5c40cd840f3f1b001fb2882f', json: true })
];

Promise.all(promises)
  .then((res, res2) => {
    const combined = res[0].campaigns.concat(res[1].campaigns);
    const date = (new Date()).toLocaleString().split(" ").join("_");

    const parsed = combined.map((campaign) => {
      return {
        "Organization": campaign.name,
        "Average Donations": campaign.average_donation,
        "Total Amount Raised": campaign.total_raised_family,
        "Total Donations": campaign.total_donations,
        "Total Supporters": campaign.total_supporters
      };
    });
    fs.writeFileSync(`pdog-parsed-${date}.json`, JSON.stringify(parsed));

    const giftsPerDonorParsed = combined.map((campaign) => {
      return {
        "Organization": campaign.name,
        "Average Number of Gifts per Donor": (campaign.total_donations / campaign.total_supporters)
      };
    });
    fs.writeFileSync(`pdog-giftsperdonor-parsed-${date}.json`, JSON.stringify(giftsPerDonorParsed));
  });
