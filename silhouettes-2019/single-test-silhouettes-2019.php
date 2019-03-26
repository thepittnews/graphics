<?php
/**
* WP Post Template: Test Silhouettes 2019
*/

$credits = explode(" & ", get_post_meta($post->ID, 'writer', true));
$writer = explode(" ", $credits[0]);
$photos = explode(" ", $credits[1]);
$combined_writer = $writer[0] . " " . $writer[1];
?>

<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Merriweather:300,900|Oswald:300,400|Slabo+27px" rel="stylesheet">
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-66952241-1"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', 'UA-66952241-1');
    </script>

    <title><?php the_title(); ?></title>
    <meta name="viewport" content="width=device-width, initial-scale = 1.0, maximum-scale=1.0, user-scalable=no">

    <style>
      body { overflow-x: hidden; }

      /* ** TITLES and HEADER ** */
      #story-title, #header-title {
        font-weight: 900;
        font-family: 'Merriweather', serif;
        color: white;
      }

      #story-title {
        background-color: rgba(0, 0, 0, 0);
        height: 0px;
        position: relative;
        top: -225px;
        left: 100px;
        font-size: 50px;
        max-width: 80%;
        display: block;
      }

      #header-title {
        margin-left: auto;
        margin-right: auto;
        float: right;
        padding-right: 20px;
        opacity: 0;
        transition: all 1s linear;
      }

      .show-title {
        opacity: 1 !important;
        transition: all 1s linear;
      }

      nav {
        background-color: #212121 !important;
        opacity: 0.8;
      }

      .brand-logo {
        height: 40px;
        margin-top: 10px;
        margin-left: 10px;
      }

      #author-info, #date-info {
        font-family: 'Oswald', sans-serif;
        font-size: 20px;
      }

      #date-info {
        font-weight: 300;
        font-size: 18px;
      }

      /* ** QUOTES ** */
      .show-quote {
        right: 0px !important;
        transition: right 1s ease-out, border-left 2s ease-in;
        border-left: 5px solid #5ca0c3 !important;
      }

      blockquote {
        font-family: 'Merriweather', serif;
        font-weight: 900;
        border-left: 5px solid white;

        float: right;
        max-width: 250px;
        font-weight: bold;
        padding: 13px;
        margin: 0 13px 13px 0;
      }

      /* ** GENERAL CSS ** */
      .container a:hover {
        background-color: aliceblue;
        transition: background-color .5s linear;
      }

      p {
        font-family: 'Merriweather', serif;
        font-weight: 300;
      }

      p:first-child:first-letter {
        float: left;
        font-size: 75px;
        line-height: 60px;
        padding-top: 4px;
        padding-right: 8px;
        padding-left: 3px;
      }

      .header-image {
        width: 100%;
        height: 100vh;
        object-fit: cover;
        object-position: top center;
      }

      div.parallax-container { height: 80vh; }
      .aligncenter { text-align: center; }
      .wp-caption-text { font-style: italic; }

      /* ** MEDIA ** */
      @media(min-width: 994px) {
        p { font-size: 15px !important; }
      }

      @media(max-width: 993px) {
        #header-title { display: none; }

        #story-title {
          top: -400px !important;
          left: 50px !important;
          font-size: 35px !important;
        }
      }

      .inline-quote {
        border-left: 5px solid #5ca0c3 !important;
        display: block !important;
      }

      @media(max-width: 600px) {
        #story-title { top: -225px !important; }
      }
    </style>
  </head>

  <body>
    <div class="navbar-fixed">
      <nav>
        &nbsp;
        <a href="https://pittnews.com"><img class="brand-logo" src="https://pittnews.com/wp-content/uploads/2018/03/TPN-VECTOR-BLUE-small.png" /></a>
        <span id="header-title"><?php the_title(); ?></span>
      </nav>
    </div>

    <img class="header-image" src="<?php echo get_the_post_thumbnail_url($post->ID, 'full'); ?>" />

    <div class="section white">
      <h4 id="story-title" style="background-color:rgba(0,255,0,0);"><?php the_title(); ?></h4>

      <div class="container">
        <span id="author-info">
          Written by <a style='color: inherit' href='https://pittnews.com/staff/?writer="<?php echo $combined_writer; ?>"'><?php echo $combined_writer; ?></a>
        </span><br/>
        <span id="author-info">Photos by <?php echo $photos[0] . " " . $photos[1]; ?></span><br/>
        <span id="date-info"><?php echo the_date(); ?></span><br/>
      </div>
    </div>

    <div class="section white">
      <div class="container">
        <div class="row">
          <div class="col s12 m11">
            <?php echo do_shortcode(wpautop(get_the_content())); ?>
            <div class="card card-small blue-grey darken-1">
              <div class="card-content white-text">
                <a style="text-decoration: underline; font-weight: 900; font-family: 'Merriweather', serif; color: white; font-size: 24px;" href="https://pittnews.com/silhouettes/">Read more silhouettes from The Pitt News</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>

  <script type="text/javascript">
    $(document).ready(function() {
      $('.parallax').parallax();

      $('blockquote.inline-quote').each((idx, el) => {
        const $el =  $(el);
        const elText = $el.text();
        const elStyle = $el.data('style');
        const blockquoteColumn = $el.parent().siblings()[0];

        $el.html(elText);
      });
    });

    $(window).scroll(function() {
      const scrollTop = $(window).scrollTop();
      if (scrollTop > 300) {
        $("#header-title").addClass('show-title');
      } else {
        $('#header-title').removeClass('show-title');
      }

      $("blockquote[class!='inline-quote']").each((idx, el) => {
        var $el = $(el);
        if (scrollTop > $el.offset().top - 600) {
          $el.addClass('show-quote');
        }
      });
    });
  </script>
</html>
