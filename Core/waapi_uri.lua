-- @noindex

---@alias waapi_uri
---| "ak.soundengine.executeActionOnEvent" # Executes an action on all nodes that are referenced in the specified event in a Play action. See AK::SoundEngine::ExecuteActionOnEvent.
---| "ak.soundengine.getState" # Gets the current state of a State Group. When using setState just prior to getState, allow a brief delay (no more than 10ms) for the information to update in the sound engine.
---| "ak.soundengine.getSwitch" # Gets the current state of a Switch Group for a given Game Object.
---| "ak.soundengine.loadBank" # Load a SoundBank. See AK::SoundEngine::LoadBank.
---| "ak.soundengine.postEvent" # Asynchronously post an Event to the sound engine (by event ID). See AK::SoundEngine::PostEvent.
---| "ak.soundengine.postMsgMonitor" # Display a message in the Profiler's Capture Log view.
---| "ak.soundengine.postTrigger" # Posts the specified Trigger. See AK::SoundEngine::PostTrigger.
---| "ak.soundengine.registerGameObj" # Register a game object. Registering a game object twice does nothing. Unregistering it once unregisters it no matter how many times it has been registered. See AK::SoundEngine::RegisterGameObj.
---| "ak.soundengine.resetRTPCValue" # Resets the value of a real-time parameter control to its default value, as specified in the Wwise project. See AK::SoundEngine::ResetRTPCValue.
---| "ak.soundengine.seekOnEvent" # Seeks inside all playing objects that are referenced in Play Actions of the specified Event. See AK::SoundEngine::SeekOnEvent.
---| "ak.soundengine.setDefaultListeners" # Sets the default active listeners for all subsequent game objects that are registered. See AK::SoundEngine::SetDefaultListeners.
---| "ak.soundengine.setGameObjectAuxSendValues" # Sets the Auxiliary Busses to route the specified game object. See AK::SoundEngine::SetGameObjectAuxSendValues.
---| "ak.soundengine.setGameObjectOutputBusVolume" # Set the output bus volume (direct) to be used for the specified game object. See AK::SoundEngine::SetGameObjectOutputBusVolume.
---| "ak.soundengine.setListenerSpatialization" # Sets a listener's spatialization parameters. This lets you define listener-specific volume offsets for each audio channel. See AK::SoundEngine::SetListenerSpatialization.
---| "ak.soundengine.setListeners" # Sets a single game object's active listeners. By default, all new game objects have no listeners active, but this behavior can be overridden with SetDefaultListeners(). Inactive listeners are not computed. See AK::SoundEngine::SetListeners.
---| "ak.soundengine.setMultiplePositions" # Sets multiple positions for a single game object. Setting multiple positions for a single game object is a way to simulate multiple emission sources while using the resources of only one voice. This can be used to simulate wall openings, area sounds, or multiple objects emitting the same sound in the same area. See AK::SoundEngine::SetMultiplePositions.
---| "ak.soundengine.setObjectObstructionAndOcclusion" # Set a game object's obstruction and occlusion levels. This function is used to affect how an object should be heard by a specific listener. See AK::SoundEngine::SetObjectObstructionAndOcclusion.
---| "ak.soundengine.setPosition" # Sets the position of a game object. See AK::SoundEngine::SetPosition.
---| "ak.soundengine.setRTPCValue" # Sets the value of a real-time parameter control. See AK::SoundEngine::SetRTPCValue.
---| "ak.soundengine.setScalingFactor" # Sets the scaling factor of a game object. You can modify the attenuation computations on this game object to simulate sounds with a larger or smaller affected areas. See AK::SoundEngine::SetScalingFactor.
---| "ak.soundengine.setState" # Sets the State of a State Group. See AK::SoundEngine::SetState.
---| "ak.soundengine.setSwitch" # Sets the State of a Switch Group. See AK::SoundEngine::SetSwitch.
---| "ak.soundengine.stopAll" # Stop playing the current content associated to the specified game object ID. If no game object is specified, all sounds are stopped. See AK::SoundEngine::StopAll.
---| "ak.soundengine.stopPlayingID" # Stops the current content, associated to the specified playing ID, from playing. See AK::SoundEngine::StopPlayingID.
---| "ak.soundengine.unloadBank" # Unload a SoundBank. See AK::SoundEngine::UnloadBank.
---| "ak.soundengine.unregisterGameObj" # Unregisters a game object. Registering a game object twice does nothing. Unregistering it once unregisters it no matter how many times it has been registered. Unregistering a game object while it is in use is allowed, but the control over the parameters of this game object is lost. For example, say a sound associated with this game object is a 3D moving sound. It stops moving when the game object is unregistered, and there is no way to regain control over the game object. See AK::SoundEngine::UnregisterGameObj.
---| "ak.wwise.cli.addNewPlatform" # Adds a new platform to a project. The platform must not already exist.
---| "ak.wwise.cli.convertExternalSource" # External sources conversion. Converts the external sources files for the specified project. Optionally, additional WSOURCES can be specified. External Sources are a special type of source that you can put in a sound object in Wwise. It indicates that the real sound data will be provided at runtime. While external source conversion can be triggered by SoundBank generation, this operation can be used to process sources not contained in the Wwise Project. Refer to integrating_external_sources.
---| "ak.wwise.cli.createNewProject" # Creates a blank new project. The project must not already exist. If the directory does not exist, it is created.
---| "ak.wwise.cli.dumpObjects" # Dump the objects model of a project as a JSON file.
---| "ak.wwise.cli.executeLuaScript" # Execute a Lua script. Optionally, specify additional Lua search paths, additional modules, and additional Lua scripts to load prior to the main script. The script can return a value. All arguments will be passed to the Lua script in the "wa_args" global variable.
---| "ak.wwise.cli.generateSoundbank" # SoundBank generation. SoundBank generation is performed according to the settings stored in the project. User SoundBanks Settings are normally ignored when SoundBank generation is launched from the command line. However, when using the Source Control for generated SoundBanks, the User Project Settings are loaded for the Source Control settings. Also, some of these settings can be overridden from the command line.
---| "ak.wwise.cli.migrate" # Migrates and saves the project.
---| "ak.wwise.cli.moveMediaIdsToSingleFile" # Moves the project's media IDs from its work units (.wwu) to a single file, <project-name>.mediaid. This command forces a save of all the project's work units.
---| "ak.wwise.cli.moveMediaIdsToWorkUnits" # Moves the project's media IDs from a single xml file <project-name>.mediaid to its work units (.wwu). This command forces a save of all the project's work units.
---| "ak.wwise.cli.tabDelimitedImport" # Imports a tab-delimited file to create and modify different object hierarchies. The project is automatically migrated (if required). It is also automatically saved following the import.
---| "ak.wwise.cli.updateMediaIdsInSingleFile" # Loads the project and updates the contents of <project-name>.mediaid, if it exists.
---| "ak.wwise.cli.verify" # Loads the project and does nothing else. This is useful to see the log for verification purposes without actually migrating and saving.
---| "ak.wwise.cli.waapiServer" # Starts a command-line Wwise Authoring API server, to which client applications, using the Wwise Authoring API, can connect.
---| "ak.wwise.console.project.close" # Closes the current project. This operation is synchronous.
---| "ak.wwise.console.project.create" # Creates, saves and opens new empty project, specified by path and platform. The project has no factory setting WorkUnit. This operation is synchronous.
---| "ak.wwise.console.project.open" # Opens a project, specified by path. This operation is synchronous.
---| "ak.wwise.core.audio.import" # Creates Wwise objects and imports audio files. This function does not return an error when something fails during the import process, please refer to the log for the result of each import command. This function uses the same importation processor available through the Tab Delimited import in the Audio File Importer. The function returns an array of all objects created, replaced or re-used. Use the options to specify how the objects are returned. For more information, refer to waapi_import.
---| "ak.wwise.core.audio.importTabDelimited" # Scripted object creation and audio file import from a tab-delimited file.
---| "ak.wwise.core.audio.imported" # Sent at the end of an import operation.
---| "ak.wwise.core.audio.mute" # Mutes an object.
---| "ak.wwise.core.audio.resetMute" # Unmute all muted objects.
---| "ak.wwise.core.audio.resetSolo" # Unsolo all soloed objects.
---| "ak.wwise.core.audio.solo" # Solos an object.
---| "ak.wwise.core.audioSourcePeaks.getMinMaxPeaksInRegion" # Gets the min/max peak pairs, in the given region of an audio source, as a collection of binary strings (one per channel). The strings are base-64 encoded, 16-bit signed int arrays, with min and max values being interleaved. If getCrossChannelPeaks is true, only one binary string represents the peaks across all channels globally.
---| "ak.wwise.core.audioSourcePeaks.getMinMaxPeaksInTrimmedRegion" # Gets the min/max peak pairs in the entire trimmed region of an audio source, for each channel, as an array of binary strings (one per channel). The strings are base-64 encoded, 16-bit signed int arrays, with min and max values being interleaved. If getCrossChannelPeaks is true, there is only one binary string representing peaks across all channels globally.
---| "ak.wwise.core.executeLuaScript" # Execute a Lua script. Optionally, specify additional Lua search paths, additional modules, and additional Lua scripts to load prior to the main script. The script can return a value. All arguments will be passed to the Lua script in the "wa_args" global variable.
---| "ak.wwise.core.getInfo" # Retrieve global Wwise information.
---| "ak.wwise.core.getProjectInfo" # Retrieve information about the current project opened, including platforms, languages and project directories.
---| "ak.wwise.core.log.addItem" # Adds a new item to the logs on the specified channel.
---| "ak.wwise.core.log.clear" # Clears the logs on the specified channel.
---| "ak.wwise.core.log.get" # Retrieves the latest log for a specific channel. Refer to ak_wwise_core_log_itemadded to be notified when an item is added to the log. The log is empty when used in WwiseConsole.
---| "ak.wwise.core.log.itemAdded" # Sent when an item is added to the log. This could be used to retrieve items added to the SoundBank generation log. To retrieve the complete log, refer to ak_wwise_core_log_get.
---| "ak.wwise.core.object.attenuationCurveChanged" # Sent when an attenuation curve is changed.
---| "ak.wwise.core.object.attenuationCurveLinkChanged" # Sent when an attenuation curve's link/unlink is changed.
---| "ak.wwise.core.object.childAdded" # Sent when an object is added as a child to another object.
---| "ak.wwise.core.object.childRemoved" # Sent when an object is removed from the children of another object.
---| "ak.wwise.core.object.copy" # Copies an object to the given parent. Note that if a Work Unit is copied, the operation cannot be undone and the project will be saved.
---| "ak.wwise.core.object.create" # Creates an object of type 'type', as a child of 'parent'. Refer to waapi_import for more information about creating objects. Also refer to ak_wwise_core_audio_import to import audio files to Wwise. To create Effect or Source plug-ins, use ak_wwise_core_object_set, and refer to wobjects_index for the classId.
---| "ak.wwise.core.object.created" # Sent when an object is created.
---| "ak.wwise.core.object.curveChanged" # Sent when one or many curves are changed.
---| "ak.wwise.core.object.delete" # Deletes the specified object. Note that if a Work Unit is deleted, the operation cannot be undone and the project will be saved.
---| "ak.wwise.core.object.diff" # Compares properties and lists of the source object with those in the target object.
---| "ak.wwise.core.object.get" # Performs a query and returns the data, as specified in the options, for each object in the query result. The query can specify either a 'waql' argument or a 'from' argument with an optional 'transform' argument. Refer to waql_introduction or waapi_query for more information. Refer to waapi_query_return to learn about options.
---| "ak.wwise.core.object.getAttenuationCurve" # Gets the specified attenuation curve for a given attenuation object.
---| "ak.wwise.core.object.getPropertyAndReferenceNames" # Retrieves the list of property and reference names for an object.
---| "ak.wwise.core.object.getPropertyInfo" # Retrieves information about an object property. Note that this function does not return the value of a property. To retrieve the value of a property, refer to ak_wwise_core_object_get and waapi_query_return.
---| "ak.wwise.core.object.getPropertyNames" # Retrieves the list of property and reference names for an object. DEPRECATED in favor of ak.wwise.core.object.getPropertyAndReferenceNames
---| "ak.wwise.core.object.getTypes" # Retrieves the list of all object types registered in Wwise's object model. This function returns the equivalent of wobjects_index.
---| "ak.wwise.core.object.isLinked" # Indicates whether a property, reference, or object list is bound to a particular platform or to all platforms.
---| "ak.wwise.core.object.isPropertyEnabled" # Returns true if a property is enabled based on the values of the properties it depends on.
---| "ak.wwise.core.object.move" # Moves an object to the given parent. Returns the moved object.
---| "ak.wwise.core.object.nameChanged" # Sent when an object is renamed. Publishes the renamed object.
---| "ak.wwise.core.object.notesChanged" # Sent when the object's notes are changed.
---| "ak.wwise.core.object.pasteProperties" # Pastes properties, references and lists from one object to any number of target objects. Only those properties, references and lists which differ between source and target are pasted. Refer to wobjects_index for more information on the properties, references and lists available on each object type.
---| "ak.wwise.core.object.postDeleted" # Sent following an object's deletion.
---| "ak.wwise.core.object.preDeleted" # Sent prior to an object's deletion.
---| "ak.wwise.core.object.propertyChanged" # Sent when the watched property of an object changes.
---| "ak.wwise.core.object.referenceChanged" # Sent when an object reference is changed.
---| "ak.wwise.core.object.set" # Allows for batch processing of the following operations: Object creation in a child hierarchy, Object creation in a list, Setting name, notes, properties and references. Refer to waapi_import for more information about creating objects. Also refer to ak_wwise_core_audio_import to import audio files to Wwise.
---| "ak.wwise.core.object.setAttenuationCurve" # Sets the specified attenuation curve for a given attenuation object.
---| "ak.wwise.core.object.setLinked" # Link or unlink a property/reference or object list to a particular platform.
---| "ak.wwise.core.object.setName" # Renames an object.
---| "ak.wwise.core.object.setNotes" # Sets the object's notes.
---| "ak.wwise.core.object.setProperty" # Sets a property value of an object for a specific platform. Refer to wobjects_index for more information on the properties available on each object type. Refer to ak_wwise_core_object_setreference to set a reference to an object. Refer to ak_wwise_core_object_get to obtain the value of a property for an object.
---| "ak.wwise.core.object.setRandomizer" # Sets the randomizer values of a property of an object for a specific platform. Refer to wobjects_index for more information on the properties available on each object type.
---| "ak.wwise.core.object.setReference" # Sets an object's reference value. Refer to wobjects_index for more information on the references available on each object type.
---| "ak.wwise.core.object.setStateGroups" # Sets the State Group objects associated with an object. Note, this will remove any previously associated State Group.
---| "ak.wwise.core.object.setStateProperties" # Set the state properties of an object. Note, this will remove any previous state property, including the default ones.
---| "ak.wwise.core.plugin.getList" # Retrieves the list of all object types registered in Wwise's object model. This function returns the equivalent of wobjects_index. DEPRECATED in favor of ak.wwise.core.object.getTypes
---| "ak.wwise.core.plugin.getProperties" # Retrieves the list of property and reference names for an object. DEPRECATED in favor of ak.wwise.core.object.getPropertyAndReferenceNames
---| "ak.wwise.core.plugin.getProperty" # Retrieves information about an object property. Note that this function does not return the value of a property. To retrieve the value of a property, refer to ak_wwise_core_object_get and waapi_query_return. DEPRECATED in favor of ak.wwise.core.object.getPropertyInfo
---| "ak.wwise.core.profiler.captureLog.itemAdded" # Sent when a new entry is added to the capture log. Note that all entries are being sent. No filtering is applied as opposed to the Capture Log view.
---| "ak.wwise.core.profiler.enableProfilerData" # Specifies the type of data you want to capture. Overrides the user's profiler settings.
---| "ak.wwise.core.profiler.gameObjectRegistered" # Sent when a game object has been registered.
---| "ak.wwise.core.profiler.gameObjectReset" # Sent when the game objects have been reset, such as closing a connection to a game while profiling.
---| "ak.wwise.core.profiler.gameObjectUnregistered" # Sent when a game object has been unregistered.
---| "ak.wwise.core.profiler.getAudioObjects" # Retrieves the Audio Objects at a specific profiler capture time.
---| "ak.wwise.core.profiler.getBusses" # Retrieves the busses at a specific profiler capture time.
---| "ak.wwise.core.profiler.getCpuUsage" # Retrieves CPU usage statistics at a specific profiler capture time. This data can also be found in the Advanced Profiler, under the CPU tab. To ensure the CPU data is received, refer to ak_wwise_core_profiler_enableprofilerdata. The returned data includes "Inclusive" and "Exclusive" values, where "Inclusive" refers to the time spent in the element plus the time spent in any called elements, and "Exclusive" values pertain to execution only within the element itself.
---| "ak.wwise.core.profiler.getCursorTime" # Returns the current time of the specified profiler cursor, in milliseconds.
---| "ak.wwise.core.profiler.getGameObjects" # Retrieves the game objects at a specific profiler capture time.
---| "ak.wwise.core.profiler.getLoadedMedia" # Retrieves the loaded media at a specific profiler capture time. This data can also be found in the Advanced Profiler, under the Loaded Media tab. To ensure the Loaded Media data is received, refer to ak_wwise_core_profiler_enableprofilerdata.
---| "ak.wwise.core.profiler.getPerformanceMonitor" # Retrieves the Performance Monitor statistics at a specific profiler capture time. Refer to globalcountersids for the available counters.
---| "ak.wwise.core.profiler.getRTPCs" # Retrieves active RTPCs at a specific profiler capture time.
---| "ak.wwise.core.profiler.getStreamedMedia" # Retrieves the streaming media at a specific profiler capture time. This data can also be found in the Advanced Profiler, under the Streams tab. To ensure the Streams data is received, refer to ak_wwise_core_profiler_enableprofilerdata.
---| "ak.wwise.core.profiler.getVoiceContributions" # Retrieves all parameters affecting voice volume, highpass and lowpass for a voice path, resolved from pipeline IDs.
---| "ak.wwise.core.profiler.getVoices" # Retrieves the voices at a specific profiler capture time.
---| "ak.wwise.core.profiler.saveCapture" # Saves profiler as a.prof file according to the given file path.
---| "ak.wwise.core.profiler.startCapture" # Starts the profiler capture and returns the time at the beginning of the capture, in milliseconds.
---| "ak.wwise.core.profiler.stateChanged" # Sent when a state group state has been changed. This subscription does not require the profiler capture log to be started.
---| "ak.wwise.core.profiler.stopCapture" # Stops the profiler capture and returns the time at the end of the capture, in milliseconds.
---| "ak.wwise.core.profiler.switchChanged" # Sent when a switch group state has been changed. This function does not require the profiler capture log to be started.
---| "ak.wwise.core.project.loaded" # Sent when the project has been successfully loaded.
---| "ak.wwise.core.project.postClosed" # Sent when the after the project is completely closed.
---| "ak.wwise.core.project.preClosed" # Sent when the project begins closing.
---| "ak.wwise.core.project.save" # Saves the current project.
---| "ak.wwise.core.project.saved" # Sent when the project has been saved.
---| "ak.wwise.core.remote.connect" # Connects the Wwise Authoring application to a Wwise Sound Engine running executable or to a saved profile file. The host must be running code with communication enabled. If only "host" is provided, Wwise connects to the first Sound Engine instance found. To distinguish between different instances, you can also provide the name of the application to connect to.
---| "ak.wwise.core.remote.disconnect" # Disconnects the Wwise Authoring application from a connected Wwise Sound Engine running executable.
---| "ak.wwise.core.remote.getAvailableConsoles" # Retrieves all consoles available for connecting Wwise Authoring to a Sound Engine instance.
---| "ak.wwise.core.remote.getConnectionStatus" # Retrieves the connection status.
---| "ak.wwise.core.sound.setActiveSource" # Sets which version of the source is being used for the specified sound. Use ak_wwise_core_object_get with the 'activeSource' return option to get the active source of a sound.
---| "ak.wwise.core.soundbank.convertExternalSources" # Converts the external sources files for the project as detailed in the wsources file, and places them into either the default folder, or the folder specified by the output argument. External Sources are a special type of source that you can put in a Sound object in Wwise. It indicates that the real sound data will be provided at run time. While External Source conversion is also triggered by SoundBank generation, this operation can be used to process sources not contained in the Wwise Project. Please refer to Wwise SDK help page "Integrating External Sources".
---| "ak.wwise.core.soundbank.generate" # Generate a list of SoundBanks with the import definition specified in the WAAPI request. If you do not write the SoundBanks to disk, subscribe to ak_wwise_core_soundbank_generated to receive SoundBank structure info and the bank data as base64. Note: This is a synchronous operation.
---| "ak.wwise.core.soundbank.generated" # Sent when a single SoundBank is generated. This could be sent multiple times during SoundBank generation, for every SoundBank generated and for every platform. To generate SoundBanks, refer to ak_wwise_core_soundbank_generate or ak_wwise_ui_commands_execute with one of the SoundBank generation commands. Refer to globalcommandsids for the list of commands.
---| "ak.wwise.core.soundbank.generationDone" # Sent when all SoundBanks are generated. Note: This notification is only sent when SoundBanks have been generated, it is not a reliable way to determine when ak_wwise_core_soundbank_generate has completed.
---| "ak.wwise.core.soundbank.getInclusions" # Retrieves a SoundBank's inclusion list.
---| "ak.wwise.core.soundbank.processDefinitionFiles" # Imports SoundBank definitions from the specified file. Multiple files can be specified. See the WAAPI log for status messages.
---| "ak.wwise.core.soundbank.setInclusions" # Modifies a SoundBank's inclusion list. The 'operation' argument determines how the 'inclusions' argument modifies the SoundBank's inclusion list; 'inclusions' may be added to / removed from / replace the SoundBank's inclusion list.
---| "ak.wwise.core.sourceControl.add" # Add files to source control. Equivalent to Mark for Add for Perforce.
---| "ak.wwise.core.sourceControl.checkOut" # Check out files from source control. Equivalent to Check Out for Perforce.
---| "ak.wwise.core.sourceControl.commit" # Commit files to source control. Equivalent to Submit Changes for Perforce.
---| "ak.wwise.core.sourceControl.delete" # Delete files from source control. Equivalent to Mark for Delete for Perforce.
---| "ak.wwise.core.sourceControl.getSourceFiles" # Retrieve all original files.
---| "ak.wwise.core.sourceControl.getStatus" # Get the source control status of the specified files.
---| "ak.wwise.core.sourceControl.move" # Move or rename files in source control. Always pass the same number of elements in files and newFiles. Equivalent to Move for Perforce.
---| "ak.wwise.core.sourceControl.revert" # Revert changes to files in source control.
---| "ak.wwise.core.sourceControl.setProvider" # Change the source control provider and credentials. This is the same setting as the Source Control option in the Project Settings dialog in Wwise.
---| "ak.wwise.core.switchContainer.addAssignment" # Assigns a Switch Container's child to a Switch. This is the equivalent of doing a drag&drop of the child to a state in the Assigned Objects view. The child is always added at the end for each state.
---| "ak.wwise.core.switchContainer.assignmentAdded" # Sent when an assignment is added to a Switch Container.
---| "ak.wwise.core.switchContainer.assignmentRemoved" # Sent when an assignment is removed from a Switch Container.
---| "ak.wwise.core.switchContainer.getAssignments" # Returns the list of assignments between a Switch Container's children and states.
---| "ak.wwise.core.switchContainer.removeAssignment" # Removes an assignment between a Switch Container's child and a State.
---| "ak.wwise.core.transport.create" # Creates a transport object for the given Wwise object. The return transport object can be used to play, stop, pause and resume the Wwise object via the other transport functions.
---| "ak.wwise.core.transport.destroy" # Destroys the given transport object.
---| "ak.wwise.core.transport.executeAction" # Executes an action on the given transport object, or all transport objects if none is specified.
---| "ak.wwise.core.transport.getList" # Returns the list of transport objects.
---| "ak.wwise.core.transport.getState" # Gets the state of the given transport object.
---| "ak.wwise.core.transport.prepare" # Prepare the object and its dependencies for playback. Use this function before calling PostEventSync or PostMIDIOnEventSync from IAkGlobalPluginContext.
---| "ak.wwise.core.transport.stateChanged" # Sent when the transport's state has changed.
---| "ak.wwise.core.transport.useOriginals" # Sets the Original/Converted transport toggle globally. This allows playing the original or the converted sound files.
---| "ak.wwise.core.undo.beginGroup" # Begins an undo group. Make sure to call ak_wwise_core_undo_endgroup exactly once for every ak.wwise.core.beginUndoGroup call you make. Calls to ak.wwise.core.undo.beginGroup can be nested. When closing a WAMP session, a check is made to ensure that all undo groups are closed. If not, a cancelGroup is called for each of the groups still open.
---| "ak.wwise.core.undo.cancelGroup" # Cancels the last undo group.
---| "ak.wwise.core.undo.endGroup" # Ends the last undo group.
---| "ak.wwise.core.undo.redo" # Redoes the last operation in the Undo stack.
---| "ak.wwise.core.undo.undo" # Undoes the last operation in the Undo stack.
---| "ak.wwise.debug.assertFailed" # Sent when an assert has failed. This is only available in Debug builds.
---| "ak.wwise.debug.enableAsserts" # Enables debug assertions. Every call to enableAsserts with 'false' increments the ref count. Calling with true decrements the ref count. This is only available with Debug builds.
---| "ak.wwise.debug.enableAutomationMode" # Enables or disables the automation mode for Wwise. This reduces the potential interruptions caused by message boxes and dialogs. For instance, enabling the automation mode silently accepts: project migration, project load log, EULA acceptance, project licence display and generic message boxes.
---| "ak.wwise.debug.generateToneWAV" # Generate a WAV file playing a tone with a simple envelope and save it to the specified location. This is provided as a utility to generate test WAV files.
---| "ak.wwise.debug.getWalTree" # Retrieves the WAL tree, which describes the nodes that are synchronized in the Sound Engine. Private use only.
---| "ak.wwise.debug.restartWaapiServers" # Restart WAAPI servers. For internal use only.
---| "ak.wwise.debug.testAssert" # Private use only.
---| "ak.wwise.debug.testCrash" # Private use only.
---| "ak.wwise.ui.bringToForeground" # Bring Wwise main window to foreground. Refer to SetForegroundWindow and AllowSetForegroundWindow on MSDN for more information on the restrictions. Refer to ak.wwise.core.getInfo to obtain the Wwise process ID for AllowSetForegroundWindow.
---| "ak.wwise.ui.captureScreen" # Captures a part of the Wwise UI relative to a view.
---| "ak.wwise.ui.commands.execute" # Executes a command. Some commands can take a list of objects as parameters. Refer to globalcommandsids for the available commands.
---| "ak.wwise.ui.commands.executed" # Sent when a command is executed. The objects for which the command is executed are sent in the publication.
---| "ak.wwise.ui.commands.getCommands" # Gets the list of commands.
---| "ak.wwise.ui.commands.register" # Registers an array of add-on commands. Registered commands remain until the Wwise process is terminated. Refer to defining_custom_commands for more information about registering commands. Also refer to ak_wwise_ui_commands_executed.
---| "ak.wwise.ui.commands.unregister" # Unregisters an array of add-on UI commands.
---| "ak.wwise.ui.getSelectedObjects" # Retrieves the list of objects currently selected by the user in the active view.
---| "ak.wwise.ui.project.close" # Closes the current project.
---| "ak.wwise.ui.project.create" # Creates, saves and opens new empty project, specified by path and platform. The project has no factory setting WorkUnit. Please refer to ak_wwise_core_project_loaded for further explanations on how to be notified when the operation has completed.
---| "ak.wwise.ui.project.open" # Opens a project, specified by path. Please refer to ak_wwise_core_project_loaded for further explanations on how to be notified when the operation has completed.
---| "ak.wwise.ui.selectionChanged" # Sent when the selection changes in the project.
---| "ak.wwise.waapi.getFunctions" # Retrieves the list of functions.
---| "ak.wwise.waapi.getSchema" # Retrieves the JSON schema of a Waapi URI.
---| "ak.wwise.waapi.getTopics" # Retrieves the list of topics to which a client can subscribe.