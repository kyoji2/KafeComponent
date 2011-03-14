/*
 * StandardAnimation Setup
 * By Kevin Cao(http://kevincao.com)
 * 2011.3.14
 */

var transitionIn = "animationIn";
var transitionInComplete = "animationInComplete";
var transitionOut = "animationOut";
var transitionOutComplete = "animationOutComplete"; 

var timeline = fl.getDocumentDOM().getTimeline();
timeline.insertFrames(79);

// labels layer
var layerIndex = timeline.addNewLayer("labels");
timeline.setLayerProperty('locked', true);

timeline.setSelectedFrames([]);
timeline.insertKeyframe(1);
timeline.setFrameProperty('name', transitionIn);
timeline.insertKeyframe(20);
timeline.setFrameProperty('name', transitionInComplete);
timeline.insertKeyframe(40);
timeline.setFrameProperty('name', transitionOut);
timeline.insertKeyframe(60);
timeline.setFrameProperty('name', transitionOutComplete);

/*
// as layer
var layerIndex = timeline.addNewLayer("as");
timeline.setLayerProperty('locked', true);

timeline.setSelectedFrames([]);
timeline.layers[layerIndex].frames[1].actionScript='import flash.events.Event;\ndispatchEvent(new Event("'+transitionIn+'"));';
timeline.insertKeyframe(20);
timeline.layers[layerIndex].frames[20].actionScript='import flash.events.Event;\ndispatchEvent(new Event("'+transitionInComplete+'"));\nstop();';
timeline.insertKeyframe(40);
timeline.layers[layerIndex].frames[40].actionScript='import flash.events.Event;\ndispatchEvent(new Event("'+transitionOut+'"));';
timeline.insertKeyframe(60);
timeline.layers[layerIndex].frames[60].actionScript='import flash.events.Event;\ndispatchEvent(new Event("'+transitionOutComplete+'"));\nstop();';
*/

// Select the first frame of default layer
timeline.setSelectedFrames([layerIndex + 1, 0, 1]);
