Class {
	#name : #PjRestAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTWaitUntilReady',
	#classTraits : 'PjTWaitUntilReady classTrait',
	#instVars : [
		'nameInput',
		'sayHelloButton',
		'greetingMessageContainer'
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
	nameInput := document getElementById: #nameTextInput.
	sayHelloButton := document getElementById: #sayHelloButton.
	greetingMessageContainer := document getElementById: #greetingMessageContainer.
]

{ #category : #waiting }
PjRestAppTest >> test1 [
	self changeElement: nameInput value: 'https://api.agify.io?name=bella'. 
	self clickElement: sayHelloButton.
	self assert: (greetingMessageContainer innerHTML) equals: '{"name":"bella","age":35,"count":40138}'
]
