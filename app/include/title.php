<?php

function get_title($request) {
	
	switch (strtolower($request[0])) {
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