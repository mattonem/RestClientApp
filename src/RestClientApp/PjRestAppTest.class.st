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
	1halt
]