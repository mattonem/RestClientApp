"
A PjHttpClientTest is a test class for testing the behavior of PjHttpClient
"
Class {
	#name : #PjHttpClientTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'PjHttpClient-Tests-Core'
}

{ #category : #'suite parameters' }
PjHttpClientTest class >> appClass [

	^ PjMinimalFileBasedWebApp
]

{ #category : #test }
PjHttpClientTest >> testGetDo [

	self evalBlock: [ global js_at: 'passed' put: false ].
	self evalBlock: [
		| client |
		client := PjHttpClient new.
		client
			getUrl:
			'https://raw.githubusercontent.com/PharoJS/PharoJS/c00b06d38cc897eb22912c9f333833f8747a8f00/CordovaExamples/Counter/package.json'
			do: [ global js_at: 'passed' put: true ] ].
	1 second wait.
	self assert: (self evalBlock: [ global js_at: 'passed' ])
]

{ #category : #test }
PjHttpClientTest >> testOnLoad [

	self evalBlock: [
		| client req |
		global instVarNamed: #testPassed put: false.
		client := PjHttpClient new.
		client onLoad: [ global instVarNamed: #testPassed put: true ].
		req := client
			       method: 'GET'
			       url:
			       'https://raw.githubusercontent.com/PharoJS/PharoJS/c00b06d38cc897eb22912c9f333833f8747a8f00/CordovaExamples/Counter/package.json'.
		req send: '' ].
	0.5 second wait.
	self assert: (self evalBlock: [ global instVarNamed: #testPassed ])
]

{ #category : #test }
PjHttpClientTest >> testSyncGet [

	| req2 |
	req2 := self evalBlock: [
		        | client req |
		        client := PjHttpClient new.
		        req := client
			               syncMethod: 'GET'
			               url:
			               'https://raw.githubusercontent.com/PharoJS/PharoJS/c00b06d38cc897eb22912c9f333833f8747a8f00/CordovaExamples/Counter/package.json'.
		        req send: ''.
		        req ].
	self assert: req2 status equals: 200
]