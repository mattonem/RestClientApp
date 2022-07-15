Class {
	#name : #PjRestAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTWaitUntilReady',
	#classTraits : 'PjTWaitUntilReady classTrait',
	#instVars : [
		'urlInput',
		'submitButton',
		'resultPre'
	],
	#category : #'RestClientApp-Tests'
}

{ #category : #'suite parameters' }
PjRestAppTest class >> appClass [
	^ PjRestClient
]

{ #category : #waiting }
PjRestAppTest >> setUp [

	super setUp.
	urlInput := document getElementById: #url.
	submitButton := document getElementById: #send.
	resultPre := document getElementById: #result.
]

{ #category : #waiting }
PjRestAppTest >> test1 [
	self changeElement: urlInput value: 'https://api.agify.io?name=bella'. 
	self clickElement: submitButton.
	1 second wait. "using javascript the call is async"
	self assert: (resultPre innerHTML) equals: '{"name":"bella","age":35,"count":40138}'
]
