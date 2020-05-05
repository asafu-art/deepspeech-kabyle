# Automatic Speech Recognition (ASR) - DeepSpeech - Kabyle

This project develops a working Speech-To-Text module for kabyle language using [Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech), that can be used for any audio processing pipeline. [Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech) is an open-source automatic speech recognition (ASR) toolkit based on [Baidu's Deep Speech](https://gigaom2.files.wordpress.com/2014/12/deep_speech3_12_17.pdf) research paper. DeepSpeech project uses Google's [TensorFlow](https://www.tensorflow.org/) to make the implementation easier.

This Readme is written for [DeepSpeech](https://github.com/mozilla/DeepSpeech/releases/tag/v0.6.1) v0.6.1. Refer to Mozillla [DeepSpeech](https://github.com/mozilla/DeepSpeech) for lastest updates.

## Get Started

### Prerequisites 
- A running setup of `NVIDIA Docker`
- A host directory with 100 GB at least for training and producing intermediate data
- Host directory must be writable by `trainer` user (uid 999) (User defined in the Dockerfile)
- Kabyle Common Voice dataset `kab.tar.gz` from <https://voice.mozilla.org/kab/datasets> inside  `sources/`subdirectory of your host directory 

### Build the image

```
docker build -t dskabyle .
```
### Parameters

Parameters for the model:
- `batch_size` : ( default 96 ) to specify the batch size for training, dev and test dataset
- `n_hidden` : ( default 2048 ) to specify the number of units in the first layer
- `epochs` : ( default 75 ) to specify the number of epochs to run training for
- `learning_rate` : ( default 0.001 ) to define the learning rate of the neural network
- `dropout` : ( default 0.05 ) to define the dropout applied
- `lm_alpha`, `lm_beta` : ( default 0.66 and 1.45 respectively) define language model alpha and beta parameters
- `beam_width` : ( default 500 ) to define the beam width used by the decoder
- `early_stop` : ( default 1 ) to indicate early stop during training to avoid overfitting 
- `duplicate_sentence_count` : ( default 1 ) to specify the maximum number of times a sentence can appear in the common-voice corpus

These training parameters can always be modified at runtime using Docker environment variables.

### Run the image 

Should you have got yout host directory contaning  the needed dataset, it is to be mounted when running the Docker image. Il will contain intermediate files, chackpoints and the final generated model files.


```
docker run --tty --mount type=bind,src=PATH-TO-HOST-DIRECTORY,dst=/mnt dskabyle
```
Using environment variables, use the following commad tu run the image, with a différent number of epochs for instance.

```
docker run --tty 
--mount type=bind,src=PATH-TO-HOST-DIRECTORY,dst=/mnt 
-e EPOCHS=50
dskabyle
```

### Models and results

Models and training intermediate data are to be found in your host directory. 

Subdirectory `models/` contains the generated model `output_graph.pb`. However such a file needs to beloaded in memory when running inferene. 

Therefore, additionnal models in tflite format, to be run on mobile devices, and mmap-able format, to read data directly from disk, are generated as well. 

Training intermidiate data are kept in `checkpoints/` subdirectory. The purpose of checkpoints is to allow interruption and later resume training.

For further information, be pleased to consult [DeepSpeech Documentation](https://deepspeech.readthedocs.io/en/v0.6.1).