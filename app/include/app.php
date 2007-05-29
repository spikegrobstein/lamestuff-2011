<?php

//only define APP if it's not already defined. this will allow us to override our default location.
if (!defined('APP')) {
	define('APP', '../app/'); //the app directory
}

//define constants... should be basically self explanitory...
define('COUNTER_FILENAME', 'counter.dat');
define('COUNTER_FILE_PATH', $_SERVER['DOCUMENT_ROOT'] . '/' . COUNTER_FILENAME);

define('DEFAULT_CONTROLLER', 'index');

define('PUBLIC_DIR', './');

//directory and file names
define('CONTROLLER', 'controller');
define('TEMPLATE', 'template');
define('PARTIAL', 'partial');
define('INC', 'include');

include_once APP.'include/title.php';

function include_file($type, $name) {
	/*
	**	include a file of $type (name of folder that contains it)
	**	$name should be the base_name of the file (without extension)
	**	if $type/$name is a directory, it will include the .php file from inside that folder
	**	otherwise, it will include $type/$name.php
	**	if not found, it will print an error.
	*/
	
	$path = APP . '/' . $type . '/' . $name;
	
	//check if the requested thing is a directory, if so, recursively call and return.
	if (is_dir($path)) {
		include_file($type . '/' . $name, $name);
		return;
	}
	
	//append .php to the requested path
	$path .= '.php';
	
	if (!file_exists($path)) {
		//if debug is defined, we want to know the filename of the missing template.
		if (defined('DEBUG')) {
			raise_error("Error including $type ($name)...", array("Missing $type file"));
		} else {
			raise_error("Error including $type...", array("Missing $type file"));
		}
	} else {
		include $path;
	}
}

function include_partial($name) {
	include_file(PARTIAL, $name);
}

function include_controller($name) {
	include_file(CONTROLLER, $name);
}

function include_inc($name) {
	include_file(INC, $name);
}

function controller_exists($name) {
	return file_exists(APP.CONTROLLER.'/'.$name) || file_exists(APP.CONTROLLER.'/'.$name.'.php');
}

function print_title($controller) {
	include (APP.'controller/'.$controller.'/title.html');
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
	
	if (!file_exists(COUNTER_FILE_PATH)) {
		return -1; //error
	}
	
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
	if (!file_exists(COUNTER_FILE_PATH)) {
		return -1;
	}
	
	//this should probably be updated so it prints a better error, or better yet, silently fails
	if (!($ifile = fopen(COUNTER_FILE_PATH, "r"))) {
		echo "ERROR opening file";
		return -1;
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
		include_controller('error');
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