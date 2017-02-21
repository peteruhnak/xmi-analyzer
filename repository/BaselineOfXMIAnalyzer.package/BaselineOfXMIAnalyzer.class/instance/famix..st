dependencies
famix: spec
	spec
		project: 'Famix'
		with: [ spec
				className: #ConfigurationOfFamix;
				versionString: #stable;
				loads: #('Core');
				repository: 'http://smalltalkhub.com/mc/Moose/Famix/main/' ]