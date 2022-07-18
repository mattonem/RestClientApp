Class {
	#name : #RestClient,
	#superclass : #Object,
	#instVars : [
		'onComplete',
		'url',
		'method',
		'queryData',
		'formBodyData',
		'body',
		'contentType'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #RestClientApp
}

{ #category : #accessing }
RestClient >> body: aString [ 
	body := aString
]

{ #category : #accessing }
RestClient >> contentType: aString [ 
	contentType := aString
]

{ #category : #'as yet unclassified' }
RestClient >> encodeParam: aDict [

	<jsAlias: #encodeParam>
	| string |
	string := '?'.
	aDict keysAndValuesDo: [ :key :value | 
		string := string , key , '=' , value , '&' ].
	^ string
]

{ #category : #'as yet unclassified' }
RestClient >> formDataKey: aString value: aString2 [ 
	formBodyData at: aString put: aString2 
]

{ #category : #accessing }
RestClient >> initialize [
	super initialize.
	queryData := Dictionary new.
	formBodyData := Dictionary new
]

{ #category : #accessing }
RestClient >> method: anObject [

	method := anObject
]

{ #category : #accessing }
RestClient >> onComplete: anObject [

	onComplete := anObject
]

{ #category : #'as yet unclassified' }
RestClient >> queryDataKey: aString value: aString2 [ 
	queryData at: aString put: aString2 
]

{ #category : #actions }
RestClient >> send [

	| client |
	client := XMLHttpRequest new. 
	client open: method url: (url, (self encodeParam: queryData ) ).
	client setRequestHeader: 'content-type' value: contentType.
	client send: body.
"	self _onComplete: onComplete with: client."

]

{ #category : #accessing }
RestClient >> url: anObject [

	url := anObject
]
