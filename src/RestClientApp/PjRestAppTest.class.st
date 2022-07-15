Class {
	#name : #PjRestAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTWaitUntilReady',
	#classTraits : 'PjTWaitUntilReady classTrait',
	#instVars : [
		'urlInput',
		'submitButton',
		'resultPre',
		'methodSelect',
		'addDataButton'
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
	methodSelect := document getElementById: #method.
	addDataButton := document getElementById: #addData.
	submitButton := document getElementById: #send.
	resultPre := document getElementById: #result.
]

{ #category : #waiting }
PjRestAppTest >> testGetUrl [
	self changeElement: urlInput value: 'https://reqres.in/api/users/2'. 
	self changeElement: methodSelect value: 'GET'. 
	self clickElement: submitButton.
	1 second wait. "using javascript the call is async"
	self assert: (resultPre innerHTML) equals: '{"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}'
]

{ #category : #waiting }
PjRestAppTest >> testGetWithData [

	| dataDiv keyinput valueInput |
	self changeElement: urlInput value: 'https://reqres.in/api/users'.
	self changeElement: methodSelect value: 'GET'.

	self clickElement: addDataButton.
	dataDiv := document getElementById: #dataDiv.
	keyinput := (dataDiv getElementsByClassName: 'key') first.
	valueInput := (dataDiv getElementsByClassName: 'value') first.
	self changeElement: keyinput value: 'delay'.
	self changeElement: valueInput value: 1.
	self clickElement: submitButton.
	self waitIfAsync:1.5 second.
	self assert: (resultPre innerHTML includesSubstring: '"per_page"')
]

{ #category : #waiting }
PjRestAppTest >> testPostJson [

	self changeElement: urlInput value: 'https://reqres.in/api/users'.
	self changeElement: methodSelect value: 'POST'.
	self clickElement: submitButton.
	1 second wait. "using javascript the call is async"
	self assert: (resultPre innerHTML includesSubstring: '"createdAt"')
]

{ #category : #waiting }
PjRestAppTest >> waitIfAsync:duration [
	
]
