# Automatic Speech Recognition (ASR) - DeepSpeech - Kabyle

This project develops a working Speech-To-Text module for kabyle language using [Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech), that can be used for any audio processing pipeline. [Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech) is an open-source automatic speech recognition (ASR) toolkit based on [Baidu's Deep Speech](https://gigaom2.files.wordpress.com/2014/12/deep_speech3_12_17.pdf) research paper. DeepSpeech project uses Google's [TensorFlow](https://www.tensorflow.org/) to make the implementation easier.

This Readme is written for [DeepSpeech](https://github.com/mozilla/DeepSpeech/releases/tag/v0.6.1) v0.6.1. Refer to Mozillla [DeepSpeech](https://github.com/mozilla/DeepSpeech) for lastest updates.

## Get Started

### Prerequisites 
- A running setuo of `NVIDIA Docker`
- A host directory with 100 GB at least for training and producing intermediate data
- Kabyle Common Voice dataset `kab.tar.gz` from <https://voice.mozilla.org/kab/datasets> inside  `sources/`subdirectory of your host directory 

### Build the image

```
docker build -t dskabyle .
```
### Parameters

Parameters for the model:
- `batch_size` : to specify the batch size for training, dev and test dataset
- `epoch` : to specify the number of epochs to run training for
- `learning_rate` : to define the learning rate of the neural network
- `dropout` :  to define the dropout applied
- `lm_alpha`, `lm_beta` :  define language model alpha and beta parameters


These training parameters can always be modified at runtime using Docker environment variables.

### Run the image 

Should ou have your dataset in /mnt for unstance, run the image as following 

```
docker run --tty --mount type=bind,src=PATH-TO-HOST-DIRECTORY,dst=/mnt dskabyle
```

### Models and results

Models and training intermediate data are to be found in your host directory. 

Subdirectory `models/` contains the generated model `output_graph.pb`. However such a file needs to beloaded in memory when running inferene. 

Therefore, additionnal models in tflite format, to be run on mobile devices, and mmap-able format, to read data directly from disk, are generated as well. 

Training intermidiate data are kept in `checkpoints/` subdirectory. The purpose of checkpoints is to allow interruption and later resume training.

For further information, be pleased to consult [DeepSpeech Documentation](https://deepspeech.readthedocs.io/en/v0.6.1)