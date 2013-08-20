;(($, window) ->
	'use strict'

	$.fn.plugin = (options) ->
		return this.each ->
			
			# setting
			settings = $.extend({}, $.fn.plugin.default, options)

			# cache
			$window = $(window)
			$nav = $(@)

			timer = undefined # for setTimeout call

			if settings.transitionOpacity
				$nav.addClass('opacity')

			# hide sub-menu
			$nav.find('li').each ->
				$this = $(@)
				if $this.has('ul').length
					$this.addClass('item-with-ul').find('ul').hide()

			# cache
			$withUl = $('.item-with-ul')

			# function for hover support
			showMenu = ->
				$this = $(@)
				if $nav.hasClass('lg-screen')
					if settings.transitionOpacity
						$this.find('>ul')
						.addClass('show')
						.stop(true, true) # fix
						.animate
							height: ['toggle', 'swing']
							opacity: 'toggle'
							settings.animationSpeed
					else
						$this.find('>ul')
						.addClass('show')
						.stop(true, true)
						.animate
							height: ['toggle', 'swing']
							settings.animationSpeed
			resetMenu = ->
				$this = $(@)
				if ( $nav.hasClass('lg-screen') and $this.find('ul').hasClass('show') )
					if settings.transitionOpacity
						$this.find('>ul')
						.removeClass('show')
						.stop(true, true)
						.animate
							height: ['toggle', 'swing']
							opacity: 'toggle'
							settings.animationSpeed
					else
						$this.find('>ul')
						.removeClass('show')
						.stop(true, true)
						.animate
							height: ['toggle', 'swing']
							settings.animationSpeed


			# change class depend on viewport width and add hover support
			resizer = ->
				if $window.width() <= settings.breakpoint
					$nav.removeClass('lg-screen').addClass('sm-screen')
				else if $window.width() > settings.breakpoint
					$nav.removeClass('sm-screen').addClass('lg-screen')
					# make sure the nav is closed when go to large screens
					$nav.removeClass('show')
					# Requires hoverIntent jquery plugin http://cherne.net/brian/resources/jquery.hoverIntent.html
					if settings.hoverIntent
						$withUl.hoverIntent
							over: showMenu
							out: resetMenu
							timeout: settings.hoverIntentTimeout
					else
						$withUl.hover(
							showMenu
							resetMenu
						)

			# 

			# add touch buttons
			selector = '.item-with-ul, ' + settings.buttonSelector
			$(selector).append('<span clas="touch-button"><i class="navicon">TB</i></span>')

			# toggle touch for nav menu (main function)
			selector = settings.buttonSelector + ', ' + settings.buttonSelector + ' .touch-button'
			$(selector).on('touchstart click', (e) ->
				e.preventDefault()
				e.stopPropagation()
				bs = settings.buttonSelector
				$btnParent
			)
			# ...
			# unfinished code here, confused about author's implementation, many unnecessary code? it must be my problem
			# ...

			# toggle for sub-menus
			# ...
			# I don't understand why author add a 'show' class, I guess it's use as a state sign, to judge whether now should slideUp or slideDown
			# ...
			# unfinished code here, confused about author's implementation, many unnecessary code? it must be my problem
			# ...

			# init
			resizer()

			# call on window resize
			$window.resize( ->
				clearTimeout(timer)
				timer = setTimeout( resizer, 200)
			)




	$.fn.plugin.default =
		'breakpoint': 800					# Number: The responsive breakpoint, the unit is 'px'
		'animationSpeed': 250				# Number: default for drop down animation speed
		'transitionOpacity': false			# Boolean: default for opacity animation
		'buttonSelector': '.menu-button'	# String: default menu button class name
		'hoverIntent': false				# Boolean: Change to true for use with hoverIntent plugin
		'hoverIntentTimeout': 150			# Number: hoverIntent default timeout 

)(jQuery, window) 

# differences with author's
# - no no-js support.
# question: what is flag for?
# To add: multiple nav on same page support