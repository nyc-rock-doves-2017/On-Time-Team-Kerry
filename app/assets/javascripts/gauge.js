var gauge = function(container, configuration) {
	var that = {};
	var config = {
		size						: 200,
		clipWidth					: 200,
		clipHeight					: 110,
		ringInset					: 20,
		ringWidth					: 20,

		pointerWidth				: 10,
		pointerTailLength			: 5,
		pointerHeadLengthPercent	: 0.9,

		minValue					: 0,
		maxValue					: 60,

		minAngle					: -90,
		maxAngle					: 90,

		transitionMs				: 750,

		majorTicks					: 5,
		labelFormat					: d3.format(',g'),
		labelInset					: 10,

		arcColorFn					: d3.interpolateHsl(d3.rgb('#9ff449'), d3.rgb('#ed1e1e'))
	};
	var range = undefined;
	var r = undefined;
	var pointerHeadLength = undefined;
	var value = 0;

	var svg = undefined;
	var arc = undefined;
	var scale = undefined;
	var ticks = undefined;
	var tickData = undefined;
	var pointer = undefined;

	var donut = d3.layout.pie();

	function deg2rad(deg) {
		return deg * Math.PI / 180;
	}

	function newAngle(d) {
		var ratio = scale(d);
		var newAngle = config.minAngle + (ratio * range);
		return newAngle;
	}

	function configure(configuration) {
		var prop = undefined;
		for ( prop in configuration ) {
			config[prop] = configuration[prop];
		}

		range = config.maxAngle - config.minAngle;
		r = config.size / 2;
		pointerHeadLength = Math.round(r * config.pointerHeadLengthPercent);

		// a linear scale that maps domain values to a percent from 0..1
		scale = d3.scale.linear()
			.range([0,1])
			.domain([config.minValue, config.maxValue]);

		ticks = scale.ticks(config.majorTicks);
		tickData = d3.range(config.majorTicks).map(function() {return 1/config.majorTicks;});

		arc = d3.svg.arc()
			.innerRadius(r - config.ringWidth - config.ringInset)
			.outerRadius(r - config.ringInset)
			.startAngle(function(d, i) {
				var ratio = d * i;
				return deg2rad(config.minAngle + (ratio * range));
			})
			.endAngle(function(d, i) {
				var ratio = d * (i+1);
				return deg2rad(config.minAngle + (ratio * range));
			});
	}
	that.configure = configure;

	function centerTranslation() {
		return 'translate('+r +','+ r +')';
	}

	function isRendered() {
		return (svg !== undefined);
	}
	that.isRendered = isRendered;

	function render(newValue) {
		svg = d3.select(container)
			.append('svg:svg')
				.attr('class', 'gauge')
				.attr('width', config.clipWidth)
				.attr('height', config.clipHeight);

		var centerTx = centerTranslation();

		var arcs = svg.append('g')
				.attr('class', 'arc')
				.attr('transform', centerTx);

		arcs.selectAll('path')
				.data(tickData)
			.enter().append('path')
				.attr('fill', function(d, i) {
					return config.arcColorFn(d * i);
				})
				.attr('d', arc);

		var lg = svg.append('g')
				.attr('class', 'label')
				.attr('transform', centerTx);
		lg.selectAll('text')
				.data(ticks)
			.enter().append('text')
				.attr('transform', function(d) {
					var ratio = scale(d);
					var newAngle = config.minAngle + (ratio * range);
					return 'rotate(' +newAngle +') translate(0,' +(config.labelInset - r) +')';
				})
				.text(config.labelFormat);

		var lineData = [ [config.pointerWidth / 2, 0],
						[0, -pointerHeadLength],
						[-(config.pointerWidth / 2), 0],
						[0, config.pointerTailLength],
						[config.pointerWidth / 2, 0] ];
		var pointerLine = d3.svg.line().interpolate('monotone');
		var pg = svg.append('g').data([lineData])
				.attr('class', 'pointer')
				.attr('transform', centerTx);

		pointer = pg.append('path')
			.attr('d', pointerLine/*function(d) { return pointerLine(d) +'Z';}*/ )
			.attr('transform', 'rotate(' +config.minAngle +')');

		update(newValue === undefined ? 0 : newValue);
	}
	that.render = render;

	function update(newValue, newConfiguration) {
		if ( newConfiguration  !== undefined) {
			configure(newConfiguration);
		}
		var ratio = scale(newValue);
		var newAngle = config.minAngle + (ratio * range);
		pointer.transition()
			.duration(config.transitionMs)
			.ease('elastic')
			.attr('transform', 'rotate(' +newAngle +')');
	}
	that.update = update;

	configure(configuration);

	return that;
};
function onDocumentReady() {
  var gaugeOneHTML = d3.select("#data-one")["0"]["0"].innerHTML
  var endRangeVal = gaugeOneHTML.indexOf(" ")
  var gaugeOneVal = gaugeOneHTML.substr(0, endRangeVal)

	if (Number(gaugeOneVal) > 60) {
		gaugeOneVal = "60"
	}

	var powerGauge1 = gauge('#power-gauge-one', {
		size: 300,
		clipWidth: 300,
		clipHeight: 175,
		ringWidth: 60,
		maxValue: 60,
		transitionMs: 4000,
	});
	powerGauge1.render();

	function updateReadings() {
		// just pump in random data here...
    // Evans/Kelsey notes - 44 will be current average delivery time for example
		powerGauge1.update(gaugeOneVal);
	}

	// every few seconds update reading values
	updateReadings();
	setInterval(function() {
		updateReadings();
	}, 5 * 1000);

  var gaugeTwoHTML = d3.select("#data-two")["0"]["0"].innerHTML
  var endRangeVal = gaugeTwoHTML.indexOf(" ")
  var gaugeTwoVal = gaugeTwoHTML.substr(0, endRangeVal)

	if (Number(gaugeTwoVal) > 60) {
		gaugeTwoVal = "60"
	}

	var powerGauge2 = gauge('#power-gauge-two', {
		size: 300,
		clipWidth: 300,
		clipHeight: 175,
		ringWidth: 60,
		maxValue: 60,
		transitionMs: 4000,
	});
	powerGauge2.render();

	function updateReadings2() {
		// just pump in random data here...
    // Evans/Kelsey notes - 44 will be current average delivery time for example
		powerGauge2.update(gaugeTwoVal);
	}

	// every few seconds update reading values
	updateReadings2();
	setInterval(function() {
		updateReadings2();
	}, 5 * 1000);
  var gaugeThreeHTML = d3.select("#data-three")["0"]["0"].innerHTML
  var endRangeVal = gaugeThreeHTML.indexOf(" ")
  var gaugeThreeVal = gaugeThreeHTML.substr(0, endRangeVal)

	if (Number(gaugeThreeVal) > 60) {
		gaugeThreeVal = "60"
	}

	var powerGauge3 = gauge('#power-gauge-three', {
		size: 300,
		clipWidth: 300,
		clipHeight: 175,
		ringWidth: 60,
		maxValue: 60,
		transitionMs: 4000,
	});
	powerGauge3.render();

	function updateReadings3() {
		// just pump in random data here...
    // Evans/Kelsey notes - 44 will be current average delivery time for example
		powerGauge3.update(gaugeThreeVal);
	}

	// every few seconds update reading values
	updateReadings3();
	setInterval(function() {
		updateReadings3();
	}, 5 * 1000);
}

if ( !window.isLoaded ) {
	window.addEventListener("load", function() {
		onDocumentReady();
	}, false);
} else {
	onDocumentReady();
}
