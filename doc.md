# Online Visuals Documentation

### Table of Contents

- Housekeeping
  - [Hiring Process](#hiring-process)
  - [Payroll]()
  - [Budgeting](#budgeting) 
- [Day-of production: Creating graphics](#day-of-production-creating-graphics)
  - [Flourish](#flourish)
  - [Leaflet](#leaflet)
  - [What Are The Odds](#what-are-the-odds)
- [Day-of production: Editor publishing process](#day-of-production-editor-publishing-process)

---

### Housekeeping

##### Hiring process

1. Confirm eligibility to be hired.
1. Interview the candidate in the conference room, and if they pass,
   candidate must sign the ethics form.
1. Tell candidate about the TPN staff layout/hierarchy.
1. Confirm with candidate when/what their training piece will be.
1. Definitions
  - WordPress: Content management system used to power
    [pittnews.com](https://pittnews.com/)
  - [Flourish](https://flourish.studio/): Tool used to build graphics
  - [R](https://www.r-project.org/): Programming language used to build
    graphics
  - [Leaflet](https://leafletjs.com/): JavaScript library used to build
    interactive maps
1. Review how the assignment process works.
1. Review how the publishing process works.
1. Set them up on Slack, and add them to the Staff channel.
1. Tell candidate they need to see Denise to setup payroll.
1. Questions or concerns?
1. Office tour

### Payroll

### Budgeting

The Editor must attend the weekly Editorial meeting, and request copies of the budgets for all other desks.

**Budgeting process:**

- Duplicate the budget template, and create a desk budget for the week
- While reading through the budgets for the other desks, look for stories that can be aided through the use of graphics. Add them to your desk budget.
- Ensure that there are no more than three nights with graphics budgeted. Rearrange the budget to fit this constraint.

The Editor must also hold a weekly desk meeting, usually held immediately after the weekly Editorial meeting, to give out budget "assignments." Ensure that all graphics have been assigned before the end of the meeting. Writers should work out of the TPN newsroom, and arrive around 7:30 p.m. on production nights.

### Day-of production: Creating graphics

##### Leaflet

1. Go to 

##### Flourish

1. Log into `app.flourish.studio` with the TPN credentials.
1. Hit "new," and select a type for the graphic
1. Name the graphic `MM/DD/YY` and then a short description of the graphic.
1. Click "Data" and enter the data for the graphic.
1. In the footer dropdown, set the source and add attribution (ex: `Graphic by Jon Moss | Online Visual Editor`) in the "Note" field.
1. In the header dropdown, set the title.
1. Hit export and publish in the top right corner.
1. Send the `public.flourish.studio` link to the Editor.

##### What Are The Odds

1. Get the story from the Sports Desk.
1. If you have not already, download a `.zip` copy of the [`pittnews434/graphics` GitHub repository](https://github.com/pittnews434/graphics).
1. Install [R](https://wwww.r-project.org) if you have not already.
1. Change directories into `what-are-the-odds`.
1. Duplicate an existing `data-*.csv` file, and change the name to include the current publication date: `data-YYYY-MM-DD.csv`.
1. Update the `name`s, get odds data for the `points` column from [OddsShark](https://www.oddsshark.com/) expected scores, and team colors for the `fill` column from [Team Color Codes](https://teamcolorcodes.com/).
1. Run `r -f odds_dep.R` if you haven't already to install dependencies.
1. Update the `date` variable, and graphic artist credit if necessary, in `odds.R`.
1. Run `r -f odds.R`, and verify the appropriate images were created.
1. Send the created images to the Editor.

### Day-of production: Editor publishing process

**Get it Started:**

- Create an "In The Works" Trello card in Today's Stories for each
   visual, using the prefix `OV: `. Include the graphic on the card, by
linking to the version live at `pittnews434.herokuapp.com`.
- Review visual(s) once writer is ready.
- Move to `Pre-read` and post in the `web18-19` channel once ready for review.

**Time for Cutlines:**
- Create another "In The Works" Trello card in Today's Stories, using the
   prefix `OV: `, with a Google document containing "cutlines" for each graphic.
   Cutlines should contain a short sentence explaining the graphic,
followed by a period, and then `Graphic by: First Last | Position.`.
- Follow normal editing and copy-editing procedures. Keep in touch with
   the desk editors for the graphic's story.

**Postin' Time:**

Once the story is in "send", create a WordPress post for the story, and place your cursor in the editor where you'd like the graphic to be inserted.

- Post the graphic
  - HTML-driven graphics
    - Switch the content editor from "Visual" to "Text" mode.
    - Paste in the HTML code for the graphic.
  - JavaScript-driven graphics
    - In the content editor toolbar, click the "Wp-D3" button.
    - Click "New Tab," and paste your JavaScript code into the code editor.
    - Click "Save" and then "Insert."
  - Image-driven graphics
    - If uploading a "What Are The Odds" graphic, make sure the image width is less than 2,000 pixels. If too big, open the file in Preview, select Tools, select Adjust Size, and make the image 50% of its current size.
    - In the WordPress UI, click "media" on the left toolbar, and upload the file.
    - Put the cutline in the caption field, and put the attribution (ex: `Graphic by Jon Moss | Online Visual Editor`) in the photographer field.
- Place custom `<head>` content (such as CSS stylesheets or JavaScript
   includes) into the "Add to head" text area.
- Place custom CSS into the "CSS Editor" text area.
- Alert the desk editors for the graphic's story that Online Visuals is
   ready to publish.
- Once the graphic has been inserted, alert the writer that their work is complete.

---

##### Publishing process: writer

1. Start a new Git branch in the `pittnews434/graphics` GitHub
   repository on your computer.
1. Create a new folder for your project, and then create the graphic.
1. Commit and push the branch to Github, and open up a Pull Request for
   your branch.
1. Alert the editor that the project is now ready for review.
1. Have editing comments back and forth with the editor.
1. Editor will alert once graphic is in the "copy" stage, and writer is
   "deadline complete."
