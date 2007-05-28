<?php

$r = get_request();
if (count($r) == 0) {
	$controller = 'index';
} else {
	$controller = $r[0];
}

?>
<a title="About <?php echo $_SERVER['HTTP_HOST']; ?>" href="/"<?php if($controller == 'index') {?> class="current"<?php } ?>>About</a>
<a title="Work History and Skillset" href="/resume/"<?php if($controller == 'resume') {?> class="current"<?php } ?>>R&eacute;sum&eacute;</a>
<a title="Examples of Previous Work" href="/portfolio/"<?php if($controller == 'portfolio') {?> class="current"<?php } ?>>Portfolio</a>
<a title="Contact Me" href="/contact/"<?php if($controller == 'contact') {?> class="current"<?php } ?>>Contact</a>
