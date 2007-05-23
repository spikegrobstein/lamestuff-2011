<?php
	include('lamestuff.inc.php');
	
	session_start();
	
	if (!isset($_SESSION['counted'])) {
		$_SESSION['counted'] = true;
		$counter = increment_counter();
	} else {
		$counter = read_counter();
	}

	//let's get the request...
	$request = get_request();
	$controller = array_shift($request);
	
	//we've gotta check to make sure the controller exists... if not, we've gotta do a redirect...
	if (!file_exists(CONTROLLER.$controller)) {
		//if the file doesn't exist, redirect to error controller...
		raise_error(404, 'controller', $controller);
	}
	
?><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Lamestuff::<?php readfile(get_controller_file($controller, 'title.html')); ?></title>
	<link rel="stylesheet" href="/lamestuff.css" type="text/css" media="screen" title="default" charset="utf-8" />
	<base href="http://<?PHP echo $_SERVER['HTTP_HOST']; ?>" />
	<meta name="generator" content="TextMate http://macromates.com/">
	<meta name="author" content="spike">
	<!-- Visitors: <?php echo $counter; ?> -->
</head>
<body>
	<a name="top"></a>
	<div id="header">
		<img src="<?php echo get_controller_file($controller, 'title.gif'); ?>">
	</div>
	<div id="navigation">
		<?php include(NAVIGATION); ?>
	</div>
	<div id="content">
		<?php include(get_controller_file($controller, 'content.php')); ?>
	</div>
	<div id="footer">
		<?php include(FOOTER); ?>
	</div>
	<div id="badges">
		<div class="badges_container">
			<a href="http://www.php.net"><img src="/images/php-icon-black.gif"></a>
			<a href="http://www.spreadfirefox.com/?q=affiliates&amp;id=0&amp;t=82"><img border="0" alt="Get Firefox!" title="Get Firefox!" src="http://sfx-images.mozilla.org/affiliates/Buttons/80x15/white_1.gif"/></a>
		</div>
	</div>
</body>
</html>
