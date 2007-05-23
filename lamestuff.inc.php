<?php

//define constants... should be basically self explanitory...
define('COUNTER_FILENAME', 'counter.dat');
define('COUNTER_FILE_PATH', $_SERVER['DOCUMENT_ROOT'] . '/' . COUNTER_FILENAME);

define('DEFAULT_CONTROLLER', 'index');

//directory and file names
define('CONTROLLER', 'controller/');
define('TEMPLATE', 'template/');

define('TITLE_FILENAME', 'title.php');

define('FOOTER', TEMPLATE.'footer.php');
define('NAVIGATION', TEMPLATE.'navigation.php');

function get_controller_file($controller, $file) {
	return CONTROLLER.$controller.'/'.$file;
}

function get_request() {
	/*
	**	gets the request from the URL...
	**	www.lamestuff.com/CONTROLLER/PARAM/PARAM/PARAM....
	*/
	
	$request = $_SERVER['REQUEST_URI'];
	$request_elements = explode('/', $request);
	$request_elements = clean_request($request_elements);
	
	if (empty($request_elements)) { //if the request is empty (ie: no page requested)
		//then we'll populate the request with the DEFAULT_CONTROLLER
		$request_elements[] = DEFAULT_CONTROLLER;
	}
	
	return $request_elements;
}

function clean_request($elements) {
	/*
	**	removes empty elements from an array
	**	this is used to remove empty elements from the get_request() function
	*/
	
	$request = array();
	
	foreach($elements as $e) {
		if (!empty($e)) {
			$request[] = urldecode($e);
		}
	}
	
	return $request;
}
	
function increment_counter() {
	/*
	**	reads the counterfile, increments it, writes it, then returns the new value.
	*/
	
	$val = read_counter();
	$val++;
	
	$ofile = fopen(COUNTER_FILE_PATH, "w");
	fwrite($ofile, ($val));
	fclose($ofile);
	
	return $val;
}
	
function read_counter() {
	/*
	**	reads the counter file and returns its current value
	*/
	
	//check if counter file exists... if not, print an error.
	//this should probably be updated so it prints a better error, or better yet, silently fails
	if (!($ifile = fopen(COUNTER_FILE_PATH, "r"))) {
		echo "ERROR opening file";
		return 0;
	}
	
	$val = null;
	while(!feof($ifile)) $val .= fread($ifile, 4096);
	
	fclose($ifile);
	
	return $val;
}

function redirect_to($location) {
	/*
	**	creates a redirect (Location:) header and exits
	*/
	
	header('Location: '.$location);
	exit;
}

function raise_error($error_code, $error_type, $path) {
	/*
	**	redirects to an error page (the error controller) if the headers have not been sent
	**	if the headers have been sent (the page has already started rendering),
	**		then it inserts the error into the page
	*/
	
	//calculate the path of the error (for the redirect or for the printed error)
	if (empty($path)) {
		$error_path = '';
	} elseif (!is_array($path)) {
		$error_path = $path;
	} elseif (is_array($path) && count($path) == 1) {
		$error_path = $path[0];
	} else {
		$error_path = implode('/', $path);
	}
	
	if (!headers_sent()) {
		redirect_to('/error/'.$error_code.'/'.$error_type.'/'.$error_path);
	} else {
		global $request;
		$request = split('/', $error_code.'/'.$error_type.'/'.$error_path);
		include(get_controller_file('error', 'content.php'));
	}
}

function clean_lines($lines, $to_lower=false) {
	/*
	**	iterates through an array and:
	**		removes \n characters at the end of any item
	**		lowercases the item
	*/
	
	$rtn_lines = array();
	
	foreach($lines as $l) {
		$line = rtrim($l);
		
		if ($to_lower) {
			$line = strtolower($line);
		}
		
		$rtn_lines[] = $line;
	}
	
	return $rtn_lines;
}

function print_link($link_text, $link_address, $link_title='') {
	/*
	**	prints: <a href="$link_address" title="$link_title">$link_text</a>
	*/
	
	echo '<a href="'.$link_address.'"';
	if ($link_title != '') {
		echo ' title="'.$link_title.'"';
	}
	echo '>';
	echo $link_text.'</a>'."\n";
	
}

	
?>