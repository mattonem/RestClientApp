Class {
	#name : #PjZincServedBrowserBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#instVars : [
		'zincServer'
	],
	#category : #'PjHttpClient-App'
}

{ #category : #'accessing - defaults' }
PjZincServedBrowserBridgeClient >> defaultAppClass [

	^ PjFileBasedWebApp
]

{ #category : #'accessing - files' }
PjZincServedBrowserBridgeClient >> folderName [

	^ self appClass appFullHtmlFolderPath 
]

{ #category : #actions }
PjZincServedBrowserBridgeClient >> startJsInterpreter [
	"start javascript interpreter"

	zincServer := self startZincServerOn: self folderName fullName.
	WebBrowser
		openOn: self urlString
		inBackground: false
]

{ #category : #'as yet unclassified' }
PjZincServedBrowserBridgeClient >> startZincServerOn: aString [

	| server port |
	port := 10000 + 1000 atRandom.
	server := ZnServer startDefaultOn: port.
	server delegate
		map:#'index.html' to: [ :request | 
			ZnResponse ok:
					(ZnEntity html: (aString asFileReference / 'index.html') contents) ];
		map: #'index.js' to: [ :request | 
			ZnResponse ok:
					(ZnEntity javascript: (aString asFileReference / 'index.js') contents) ].
	^ server
]

{ #category : #actions }
PjZincServedBrowserBridgeClient >> stop [
	super stop. 
]

{ #category : #actions }
PjZincServedBrowserBridgeClient >> urlString [

	^ zincServer localUrl / 'index.html'
]
