# Online Visuals Documentation

### Hiring process

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


### Publishing process: writer

1. Start a new Git branch in the `pittnews434/graphics` GitHub
   repository on your computer.
1. Create a new folder for your project, and then create the graphic.
1. Commit and push the branch to Github, and open up a Pull Request for
   your branch.
1. Alert the editor that the project is now ready for review.
1. Have editing comments back and forth with the editor.
1. Editor will alert once graphic is in the "copy" stage, and writer is
   "deadline complete."

### Publishing process: editor

1. Create an "In The Works" Trello card in Today's Stories for each
   visual, using the prefix `OV: `. Include the graphic on the card, by
linking to the version live at `pittnews434.herokuapp.com`.
1. Review visual(s) once writer is ready.
1. Move to `Pre-read` and post in the editor channel once ready.
1. Create another "Pre-read" Trello card in Today's Stories, using the
   prefix `OV: `, with a Google document containing "cutlines" for each graphic.
   Cutlines should contain a short sentence explaining the graphic,
followed by a period, and then `Graphic by: First Last | Position.`.
1. Follow normal editing and copy-editing procedures. Keep in touch with
   the desk editors for the graphic's story.
1. Once in the "copy" stage, alert the writer that their work is
   complete.
1. Once the story is in "GRAPHICS", open the WordPress post editor for the story, and
   place your cursor where you'd like the graphic to be inserted.
1. In the content editor toolbar, click the "Wp-D3" button.
1. Click "New Tab," and paste your JavaScript code into the code editor.
1. Click "Save" and then "Insert."
1. Place custom `<head>` content (such as CSS stylesheets or JavaScript
   includes) into the "Add to head" text area.
1. Place custom CSS into the "CSS Editor" text area.
1. Alert the desk editors for the graphic's story that Online Visuals is
   ready to publish.
