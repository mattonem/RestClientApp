Class {
	#name : #BaselineOfPjHttpClient,
	#superclass : #BaselineOf,
	#category : #BaselineOfPjHttpClient
}

{ #category : #baselines }
BaselineOfPjHttpClient >> baseline: spec [
	<baseline>

	self compatibility: spec.
		
	spec for: #'common' do: [
		self 
			prerequisites: spec;		
			packages: spec;
			groups: spec	
	]
]

{ #category : #baselines }
BaselineOfPjHttpClient >> compatibility: spec [
	"Define a 'Compatibility' group that can be used as a dependency later to overcome differences in Pharo releases"

]

{ #category : #baselines }
BaselineOfPjHttpClient >> groups: spec [

	"Define groups for loading"

	"Core"

	spec
		group: 'Core' with: #( 'PjHttpClient-Core' );
		group: 'Tests' with: #( 'PjHTTPClient-Tests' ).


	"Virtual groups (lowercase) from Metacello"
	spec group: 'default' with: #( 'Core' ).
	spec group: 'all' with: #( 'Tests' )
]

{ #category : #baselines }
BaselineOfPjHttpClient >> packages: spec [
		"Define and list all packages and their dependencies"
		
		"Core"
		spec package: 'PjHTTPClient-Core' with: [ spec requires: #('PharoJS') ].
		spec package: 'PjHTTPClient-App' with: [ spec requires: #('PjHTTPClient-Core') ].
		spec package: 'PjHTTPClient-Tests' with: [ spec requires: #('PjHTTPClient-App') ].
]

{ #category : #baselines }
BaselineOfPjHttpClient >> prerequisites: spec [
	"Add the projects prerequisite definitions to the given spec"	

	"Prerequisite Baselines"
	spec
		baseline: 'PharoJS' with: [ spec repository: 'github://PharoJS/PharoJS:pharo10' ].
]
