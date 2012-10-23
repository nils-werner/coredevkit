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

			Administration::instance()->Page->removeFromHead("link");
			Administration::instance()->Page->removeFromHead("script");

			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.css', 'screen', 30);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.legacy.css', 'screen', 31);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.grids.css', 'screen', 32);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.forms.css', 'screen', 34);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.tables.css', 'screen', 34);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.frames.css', 'screen', 33);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.drawers.css', 'screen', 34);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.tabs.css', 'screen', 34);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/symphony.notices.css', 'screen', 34);
			Administration::instance()->Page->addStylesheetToHead(SYMPHONY_URL . '/assets/css/admin.css', 'screen', 40);

			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/jquery.js', 50);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.js', 60);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.collapsible.js', 61);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.orderable.js', 62);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.selectable.js', 63);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.duplicator.js', 64);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.tags.js', 65);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.pickable.js', 66);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.timeago.js', 67);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.notify.js', 68);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/symphony.drawer.js', 69);
			Administration::instance()->Page->addScriptToHead(SYMPHONY_URL . '/assets/js/admin.js', 70);
		}

	}

?>