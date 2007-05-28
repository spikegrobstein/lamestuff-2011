<?php
	session_start();

	include '../app/include/app.php';
	
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
	if (!controller_exists($controller)) {
		//if the file doesn't exist, redirect to error controller...
		raise_error(404, 'controller', $controller);
	}
	
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Lamestuff::<?php echo get_title($request); ?></title>
	<link rel="stylesheet" href="/lamestuff.css" type="text/css" media="screen" title="default" charset="utf-8" />
	<base href="http://<?PHP echo $_SERVER['HTTP_HOST']; ?>" />
	<meta name="generator" content="TextMate http://macromates.com/" />
	<meta name="author" content="spike" />
	<!-- Visitors: <?php echo $counter; ?> -->
</head>
<body>
	<div id="header">
		<a name="top"></a>
		<img src="/images/titles/<?php echo $controller; ?>.gif" alt="<?php echo ucfirst(strtolower($controller)); ?>" />
	</div>
	<div id="navigation">
		<?php include_partial('navigation'); ?>
	</div>
	<div id="content">
		<?php include_controller($controller); ?>
	</div>
	<div id="footer">
		<?php include_partial('footer'); ?>
	</div>
	<div id="badges">
		<div class="badges_container">
			<a href="http://www.php.net" title="Built with PHP">
				<img src="/images/php-icon-black.gif" alt="PHP Logo" />
			</a>
			<a href="http://www.spreadfirefox.com/?q=affiliates&amp;id=0&amp;t=82" title="Get Firefox!">
				<img alt="Get Firefox!" title="Get Firefox!" src="http://sfx-images.mozilla.org/affiliates/Buttons/80x15/white_1.gif"/>
			</a>
		</div>
	</div>
</body>
</html>
