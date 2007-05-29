<?php

define('PORTFOLIO_DIR', CONTROLLER.'portfolio/');
define('PROJECT_DIR', PORTFOLIO_DIR.'projects/');

function init_portfolio_lists() {
	if ($handle = opendir(PROJECT_DIR)) { //open the directory list...
		if (!isset($_SESSION['portfolio_list'])) { //if the cookie doesnt' contain the project list, then make it.
			//initialize the arrays...
			$project_list = array();
			$showcase_list = array();
		
			$project_category_index = array();
		
			//iterate through the list and build the array
			while ($next_dir = readdir($handle)) {
				if ($next_dir[0] != ".") {
					if (file_exists(PROJECT_DIR."$next_dir/showcase.txt")) {
						//if it's a showcased project, add it to the showcase list
						$showcase_list[] = $next_dir;
					} else {
						//otherwise, add it to the general project list.
						$project_list[] = $next_dir;
					}
				
					//load the categories...
					if (file_exists(PROJECT_DIR.$next_dir.'/categories.dat')) {
						$lines = file(PROJECT_DIR.$next_dir.'/categories.dat');
						$lines = clean_lines($lines, true);
						$project_category_index[$next_dir] = $lines;
					}
				}
			}
	
			//shuffle the project lists, then merge them.
			shuffle($showcase_list);
			shuffle($project_list);
			$portfolio_list = array_merge($showcase_list, $project_list);
		
			//set the cookie.
			$_SESSION['portfolio_list'] = $portfolio_list;
			$_SESSION['last_category'] = '';
		
			//set the session variable for the category index...
			$_SESSION['project_category_index'] = $project_category_index;
		
		}
	}
}

function print_all_categories() {
	$project_list = $_SESSION['project_category_index'];
	
	$category_list = array();
	
	foreach ($project_list as $proj => $cat) {
		foreach($cat as $c) {
			if (empty($category_list[$c])) {
				$category_list[$c] = 1;
			} else {
				$category_list[$c]++;
			}
		}
	}
	
	//ok, now that we've got the array of categories, let's sort them...
	$category_names = array_keys($category_list);
	sort($category_names);
	
	?><div class="category_list"><span class="title">Categories:</span> 
	<?php
	foreach($category_names as $cat) {
		?>
			<a href="/portfolio/category/<?php echo $cat; ?>" title="List projects in the <?php echo ucwords($cat); ?> category"><?php echo $cat; ?></a><span class="category_count">(<?php echo $category_list[$cat]; ?>)</span> 
		<?php
	}
	?></div>
	<?php
}

function print_portfolio_item($item_name) {
//	global $project_dir;
	
	?>
	<div class="portfolio_object">
		<a href="/portfolio/<?php echo $item_name; ?>/" title="<?php echo $item_name; ?>">
			<img src="<?php echo PROJECT_DIR.$item_name; ?>/thumbnail.jpg" alt="<?php echo $item_name ?>" />
			<span class="title"><?php include(PROJECT_DIR."$item_name/title.php"); ?></span>
		</a>
		<div class="description"><?php include(PROJECT_DIR."$item_name/description.php"); ?></div>
	</div>
	<?php
}

function pimg_tag($img_name, $comment = '', $alt='') {
	/*
	**	prints an img tag for the image.
	*/
	
	global $project;
	
	if ($comment != '') {
		?><div class="comment"><?php echo $comment; ?>:</div><?php
	}
	?>
		<img src="<?php echo PROJECT_DIR."$project/$img_name" ?>" alt="<?php echo $alt; ?>"/>
	<?php
}

function print_keyword_list($list) {

	if (!empty($list)) {
		?><div class="category_list"><span class="title">Filed under:</span> <?php
		foreach($list as $l) {
			?><a href="/portfolio/category/<?php echo strtolower($l); ?>" title="All projects that are part of the <?php echo ucwords($l); ?> category"><?php echo $l; ?></a> <?php
		}?>
		</div><?php
	}
}

function projects_for_category($category_name) {
	/*
	**	returns an array of names of projects in $category_name
	*/
	
	$category_index = $_SESSION['project_category_index'];
	
	$project_list = array();
	
	foreach($category_index as $proj => $cat) {
	//	echo "checking ($category) in $proj\n";
		if (in_array($category_name, $cat)) {
			$project_list[] = $proj;
		}
	}
	
	return $project_list;
}

function print_portfolio_navigator($project_name) {
	/*
	**	prints a next/previous navigator for $project_name
	**	checks the $_SESSION variable for a 'last_category' field... if it's not blank, it uses that as a reference.
	*/
	
	$project_list = array();
	
	$category_name = $_SESSION['last_category'];
	
	if ($category_name != '') {
		$project_list = projects_for_category($category_name);
	} else {
		$project_list = $_SESSION['portfolio_list'];
	}
	
	$next_project = '';
	$prev_project = '';
	
	$next_project_link = '#';
	$prev_project_link = '#';
	
	for ($i = 0; $i < count($project_list); $i++) {
		if ($project_list[$i] == $project_name) {
			if ($i != 0) {
				$prev_project = $project_list[$i - 1];
				$prev_project_link = '/portfolio/'.$prev_project;
			}
			
			if ($i != count($project_list) - 1) {
				$next_project = $project_list[$i + 1];
				$next_project_link = '/portfolio/'.$next_project;
			}
		}
	}
	
	?>
	<div class="portfolio_navigator">
		<?php print_link('&larr;Prev', $prev_project_link, $prev_project); ?>
		<span>Portfolio Navigation</span>
		<?php print_link('Next&rarr;', $next_project_link, $next_project); ?>
	</div>
	<?php
}

?>

