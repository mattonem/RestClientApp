Class {
	#name : #RestClient,
	#superclass : #Object,
	#instVars : [
		'onComplete',
		'url',
		'method'
	],
	#category : #RestClientApp
}

{ #category : #'as yet unclassified' }
RestClient >> _method: aMethod url: aUrl with: aClient [

	<javascript: 'aClient.open(aMethod, aUrl)'>
	aClient
		method: aMethod;
		url: aUrl
]

{ #category : #'as yet unclassified' }
RestClient >> _onComplete: aBlock with: aClient [
	<javascript: 'aClient.onreadystatechange = function() {
    aBlock(this.response)
  };'>
	onComplete := aBlock
]

{ #category : #actions }
RestClient >> _sendWith: aClient [

	<javascript: 'aClient.send();'>
	
	^ onComplete value: aClient execute contents.
]

{ #category : #accessing }
RestClient >> method: anObject [

	method := anObject
]

{ #category : #accessing }
RestClient >> onComplete: anObject [

	onComplete := anObject
]

{ #category : #actions }
RestClient >> send [
	| client |
	client := self _newClient.  
	self _method: method url: url with: client.
	self _onComplete: onComplete with: client.
	self _sendWith: client
]

{ #category : #accessing }
RestClient >> url: anObject [

	url := anObject
]
