<?php

	class Extension_CoreDevKit extends Extension {
	/*-------------------------------------------------------------------------
		Definition:
	-------------------------------------------------------------------------*/

		public function getSubscribedDelegates() {
			return array(
						array(
							'page'		=> '/backend/',
							'delegate'	=> 'InitaliseAdminPageHead',
							'callback'	=> 'initaliseAdminPageHead'
						),
					);
		}

		public function initaliseAdminPageHead($context) {
			error_reporting(E_ALL);
			ini_set('display_errors', 1);
		}

	}

?>