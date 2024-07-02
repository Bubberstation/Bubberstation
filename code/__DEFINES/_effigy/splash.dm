#define EFFIGY_TEMP_LOADING_SCREEN 'local/interface/title-x3.png'
#define EFFIGY_TEMP_TITLE_SCREEN 'local/interface/promo_bubber_splash.png'

#define EFFIGY_TEMP_HTML {"
	<html>
		<head>
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<style type='text/css'>
				@font-face {
					font-family: 'Chakra Petch';
					font-style: normal;
					font-weight: 600;
					font-display: block;
					src: url("ChakraPetch-Semibold.ttf");
					}

				body,
				html {
					margin: 0;
					overflow: hidden;
					font-family: 'Chakra Petch';
					text-align: center;
					background-color: #202020;
					padding-top: 5vmin;
					-ms-user-select: none;
					cursor: default;
				}

				img {
					border-style:none;
				}

				.bg {
					position: absolute;
					width: auto;
					height: 100vmin;
					min-width: 100vmin;
					min-height: 100vmin;
					top: 50%;
					left:50%;
					transform: translate(-50%, -50%);
					z-index: 0;
				}

				.container_terminal {
					position: absolute;
					top: calc(84% - 3vmin);
					left: calc(50% - 456px);
					height: 3vmin;
					width: 915px;
					overflow: clip;
					box-sizing: border-box;
					z-index: 1;
				}

				.terminal_text {
					font-family: 'Chakra Petch';
					font-weight: 600;
					src: url("ChakraPetch-Semibold.ttf");
					display: inline-block;
					text-decoration: none;
					width: 100%;
					text-align: left;
					color:#EAEAEA;
					margin-right: 0%;
					margin-top: 0px;
					font-size: 2vmin;
				}

				.container_progress {
					position: absolute;
					box-sizing: border-box;
					top: 84%;
					left: calc(50% - 456px);
					height: 48px;
					width: 915px;
					background-color: #202020;
				}

				.progress_bar {
					width: 0%;
					height: 100%;
					background-color: #202020;
					background-image: url("https://cdn.effigy.se/live/rsc/loading-pets-x2.gif");
					background-position: center right;
				}

				@keyframes fade_out {
					to {
						opacity: 0;
					}
				}

				.fade_out {
					animation: fade_out 2s both;
				}

				.container_nav {
					position: absolute;
					box-sizing: border-box;
					width: 75vmin;
					min-height: 10vmin;
					top: calc(50% + 22.5vmin);
					left:50%;
					transform: translate(-50%, -50%);
					z-index: 1;
					border-radius: 0;
					background: rgba(32,32,32,0.9);
					padding: 1em;
				}

				.container_nav hr {
					height: 2px;
					background-color: #EAEAEA;
					border: none;
				}

				.menu_button {
					display: block;
					box-sizing: border-box;
					font-family: 'Chakra Petch', 'Segoe UI';
					font-weight: 600;
					text-decoration: none;
					font-size: 4vmin;
					line-height: 4vmin;
					width: 100%;
					text-align: left;
					color: #EAEAEA;
					height: 4.5vmin;
					padding-left: 1vmin;
					letter-spacing: 1px;
					cursor: pointer;
					white-space: nowrap;
					overflow: hidden;
				}

				.menu_button:hover {
					color: #202020;
					background-color: #1FC7FF;
				}

				@keyframes pollsbox {
					0% {color: #EAEAEA;}
					50% {color: #f80;}
				}

				.menu_newpoll {
					animation: pollsbox 2s step-start infinite;
					padding-left: 0px;
				}

				.container_notice {
					position: absolute;
					box-sizing: border-box;
					width: 75vmin;
					min-height: 4vmin;
					top:40%;
					left:50%;
					transform: translate(-50%, -50%);
					z-index: 1;
					border-radius: 0;
					background-color: #F02D7F;
					opacity: 75%;
					padding: 1em;
				}

				.menu_notice {
					display: block;
					box-sizing: border-box;
					font-family: 'Chakra Petch', 'Segoe UI';
					font-weight: 600;
					text-decoration: none;
					font-size: 4vmin;
					line-height: 4vmin;
					width: 100%;
					text-align: left;
					color: #202020;
					height: 4.5vmin;
					padding-left: 1vmin;
					letter-spacing: 1px;
					white-space: nowrap;
				}

				.antag_disabled {
					color: #F02D7F;
				}

				.antag_enabled {
					color: #23FA92;
				}

				.cta {
					color: #1FC7FF;
				}

				.cta:hover {
					color: #202020;
					background-color: #1FC7FF;
				}
			</style>
		</head>
		<body>
			"}

#define EFFIGY_WELCOME_MESSAGE {"Welcome to this promotional map courtesy of a collaboration between Bubberstation x Effigy!<br/>
Effigy is a server with an anthro friendly atmosphere, along with a focus of a mix of roleplay, gameplay and light antagonism.<br/>
Unlike Bubberstation, Effigy is not a downstream of either Skyrat or Nova Sector. With its own code, maps, and assets, it is a more direct /tg/station downstream. Character customization is familiar, and the server supports importing your characters and preferences from Bubberstation!<br/>
<a href="https://effigy.se">Visit effigy.se for more details or to apply to the whitelist.</a>"}

#define EFFIGY_END_MESSAGE {"Thanks for playing this promotional map courtesy of a collaboration between Bubberstation x Effigy!<br/>
Effigy is a server with an anthro friendly atmosphere, along with a focus of a mix of roleplay, gameplay and light antagonism.<br/>
Unlike Bubberstation, Effigy is not a downstream of either Skyrat or Nova Sector. With its own code, maps, and assets, it is a more direct /tg/station downstream. Character customization is familiar, and the server supports importing your characters and preferences from Bubberstation!<br/>
<a href="https://effigy.se">Visit effigy.se for more details or to apply to the whitelist.</a>"}
