<?php

/*
**	the format of the request for this page should be:
**	/error/ERROR_CODE/TYPE/path/to/requested/file
*/

if (count($request) > 0) {
	$error_code = array_shift($request);		//404, 500, whatever... usually 404
} else {
	$error_code = -1;
}

if (count($request) > 0) {
	$error_type = array_shift($request);		//controller, project, whatever...	
} else {
	$error_type = 'unknown';
}

$path = '';
$error_title = '';

//calculate the path and title based on what kind of item wasn't found...
if ($error_type == 'controller') {
	$path = array_shift($request);
	$error_title = 'File not found!';
	
	$error_msg = 'The file you requested ('.$path.') could not be located. Please check the URL and try again. There is no reason to contact me about this.';
} elseif ($error_type = 'project') {
	$path = array_shift($request);
	$error_title = 'Project does not exist!';
	
	$error_msg = 'The project '.$path.' does not exist. Please check the spelling (capitalization counts!).';
} elseif ($error_type = 'unknown') {
	$path = '';
	$error_title = 'Unknown Error!';
	
	$error_msg = 'An unknown error has occurred.';
} else {
	if (!empty($request)) {
		$path = implode('/', $request);					//the requested item that wasn't found.
	} else {
		$path = '';
	}
	$error_title = 'File not found!';
	
	$error_msg = 'The file you have requested could not be located because it is missing or has been moved.';
}

?>

<div class="error">
	<h1><?php echo $error_title; ?> <span class="error_code"><?php echo $error_code; ?></span></h1>
	<div class="error_description">
		<?php echo $error_msg; ?>
	</div>
	<div class="error_subscript">
		<a class="home_button" href="/">Go back to <?php echo $_SERVER['HTTP_HOST']?></a>
	</div>
</div>

