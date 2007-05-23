<?php

include("controller/portfolio/portfolio.inc.php");

global $project;

$project = array_shift($request);

init_portfolio_lists();

if ($project == '') {		//if we just want to list the portfolio...
	

		?>
		
		<div id="portfolio">
		
		<?php
		
		$portfolio_list = $_SESSION['portfolio_list'];
		
		print_all_categories();
		
		//print the portfolio list...
		while($next_item = array_shift($portfolio_list)) {
			print_portfolio_item($next_item);
		}
		
		?>

		</div>
	
	<?php
} else { //if there's a selected project, then display that thing!
	
	if ($project == 'category') { //if we're going to list everything in a category...
		$category = array_pop($request);
		$_SESSION['last_category'] = $category;
				
		print_all_categories(); //print the category link box
		
		?><div id="portfolio"><h1 class="listing_heading">Listing items in the category of "<?php echo ucwords($category); ?>"</h1><?php
		
		$project_list = projects_for_category($category);
		
		$found_count = count($project_list);
		
		foreach($project_list as $proj) {
			print_portfolio_item($proj);
		}
		
		if ($found_count == 0) {
			?><h2 class="listing_heading">No projects found.</h2><?php
		}
		
		?></div><?php
		
	}	elseif (!file_exists(PROJECT_DIR.$project)) { //check to see if the project doesn't exist... if not, throw an error...
		raise_error(404, 'project', $project);
	} else {
		//first, let's read the categories to print out later...
		
		$lines = array();
		$category_file = PROJECT_DIR.$project.'/categories.dat';
		if (file_exists($category_file)) {
			$lines = file($category_file);
			$lines = clean_lines($lines);
			sort($lines);
		}
		?>
		<?php print_portfolio_navigator($project); print_keyword_list($lines); ?>
		<div id="portfolio_project">
			<h1><?php include(PROJECT_DIR."$project/title.php"); ?></h1>
			<div class="intro">
				<?php include(PROJECT_DIR."$project/intro.php"); ?>
			</div>
			<div class="software"><?php include(PROJECT_DIR."$project/software.php"); ?></div>
			<?php
			include(PROJECT_DIR."$project/content.php");
			?></div><?php
			print_keyword_list($lines);
			print_portfolio_navigator($project);
		}
	}

?>