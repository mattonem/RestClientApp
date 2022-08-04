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
BaselineOfPjHttpClient >> groups: spec [

	"Define groups for loading"

	"Core"
	spec group: 'Core' with: #( 'PjHttpClient' ).

	"Virtual groups (lowercase) from Metacello"
	spec group: 'default' with: #( 'Core' )
]

{ #category : #baselines }
BaselineOfPjHttpClient >> packages: spec [
		"Define and list all packages and their dependencies"
		
		"Core"
		spec package: 'PjHTTPClient' with: [ spec requires: #('PharoJS') ].
]

{ #category : #baselines }
BaselineOfPjHttpClient >> prerequisites: spec [
	"Add the projects prerequisite definitions to the given spec"	

	"Prerequisite Baselines"
	spec
		baseline: 'PharoJS' with: [ spec repository: 'github://PharoJS/PharoJS:pharo10' ].
]
