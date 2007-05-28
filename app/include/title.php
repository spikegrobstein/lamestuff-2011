<?php

function get_title($request) {
	if (count($request) == 0) {
		$page = 'index';
	} else {
		$page = $request[0];
	}

	switch (strtolower($page)) {
		case 'index':
			return 'Index';
		case 'resume':
			return 'R&eacute;sum&eacute;';
		case 'portfolio':
			return 'Portfolio';
		case 'contact':
			return 'Contact';
		default:
			return 'UNKNOWN PAGE!';
	}
}

?>