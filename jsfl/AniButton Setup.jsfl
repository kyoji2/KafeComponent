/*
 * AniButton Setup
 * setup for AniButton Component
 * By Kevin Cao(http://kevincao.com)
 * 2010.1.14
 */

fl.getDocumentDOM().getTimeline().insertFrames(49);

fl.getDocumentDOM().getTimeline().addNewLayer('_hit');
fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', '//Place a MovieClip named "_hit" here, or leave it blank.');

fl.getDocumentDOM().getTimeline().addNewLayer('_component');
fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', '//Place AniButton Component here.');

var layerIndex = fl.getDocumentDOM().getTimeline().addNewLayer('labels');
fl.getDocumentDOM().getTimeline().setLayerProperty('locked', true);

fl.getDocumentDOM().getTimeline().setSelectedFrames([layerIndex, 0, 1]);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'intro');
fl.getDocumentDOM().getTimeline().insertKeyframe(9);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'over');
fl.getDocumentDOM().getTimeline().insertKeyframe(19);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'out');
fl.getDocumentDOM().getTimeline().insertKeyframe(29);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'down');
fl.getDocumentDOM().getTimeline().insertKeyframe(39);
fl.getDocumentDOM().getTimeline().setFrameProperty('name', 'outro');

// Select the first frame of default layer
fl.getDocumentDOM().getTimeline().setSelectedFrames([layerIndex + 3, 0, 1]);
