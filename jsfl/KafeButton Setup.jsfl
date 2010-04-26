/*
 * KafeButton Setup
 * setup for KafeButton Component
 * By Kevin Cao(http://kevincao.com)
 * 2010.1.14
 */

fl.getDocumentDOM().getTimeline().insertFrames(89);

fl.getDocumentDOM().getTimeline().addNewLayer('_hit');
fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', '//Place a MovieClip named "_hit" here, or leave it blank.');

fl.getDocumentDOM().getTimeline().addNewLayer('_component');
fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', '//Place KafeButton Component here.');

var layerIndex = fl.getDocumentDOM().getTimeline().addNewLayer("labels");
fl.getDocumentDOM().getTimeline().setLayerProperty('locked', true);

fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'over');
fl.getDocumentDOM().getTimeline().insertKeyframe(9);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'out');
fl.getDocumentDOM().getTimeline().insertKeyframe(19);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'down');
fl.getDocumentDOM().getTimeline().insertKeyframe(29);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'disabled');
fl.getDocumentDOM().getTimeline().insertKeyframe(39);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'selected');
fl.getDocumentDOM().getTimeline().insertKeyframe(49);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'selected over');
fl.getDocumentDOM().getTimeline().insertKeyframe(59);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'selected out');
fl.getDocumentDOM().getTimeline().insertKeyframe(69);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'selected down');
fl.getDocumentDOM().getTimeline().insertKeyframe(79);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'selected disabled');

// Select the first frame of default layer
fl.getDocumentDOM().getTimeline().setSelectedFrames([layerIndex + 3, 0, 1]);
