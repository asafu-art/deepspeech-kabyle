# Automatic Speech Recognition (ASR) - DeepSpeech - Kabyle

This project develops a working Speech-To-Text module for Kabyle language using [Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech), that can be used for any audio processing pipeline. [Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech) is an open-source automatic speech recognition (ASR) toolkit based on [Baidu's Deep Speech](https://gigaom2.files.wordpress.com/2014/12/deep_speech3_12_17.pdf) research paper. The DeepSpeech project uses Google's [TensorFlow](https://www.tensorflow.org/) to make the implementation easier.

This Readme is written for [DeepSpeech](https://github.com/mozilla/DeepSpeech/releases/tag/v0.8.2) v0.8.2. Refer to Mozillla [DeepSpeech](https://github.com/mozilla/DeepSpeech) for lastest updates.

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
- `batch_size` : ( default 96 ) to specify the number of elements un a batch for training, dev and test dataset
- `n_hidden` : ( default 2048 ) to specify the layer width to use when initializing layers
- `epochs` : ( default 75 ) to specify the number of epochs to run training for
- `learning_rate` : ( default 0.001 ) to define the learning rate of Adam optimizer
- `dropout` : ( default 0.05 ) to define the applied dropout rate for feedforward layers 
- `lm_alpha`: ( default 0.66 ) defines the alpha hyperparameters of the CTC decoder. Language Model weight. Word insertion weight.
- `lm_beta` : ( default 1.45 ) define the beta hyperparameters of the CTC decoder 
- `beam_width` : ( default 500 ) to define the beam width used in the CTC decoder when building candidate transcriptions
- `early_stop` : ( default 1 ) to indicate early stop during training to avoid overfitting 
- `duplicate_sentence_count` : ( default 1 ) to specify the maximum number of times a sentence can appear in the common-voice corpus

These training parameters can always be modified at runtime using Docker environment variables.

### Run the image 

Should you have got your host directory containing  the needed dataset, it is to be mounted when running the Docker image. Il will contain intermediate files, checkpoints, and the final generated model files.


```
docker run --tty --mount type=bind,src=PATH-TO-HOST-DIRECTORY,dst=/mnt dskabyle
```
Using environment variables, use the following command to run the image, with a différent number of epochs for instance.

```
docker run --tty 
--mount type=bind,src=PATH-TO-HOST-DIRECTORY,dst=/mnt 
-e EPOCHS=50
dskabyle
```

### Models and results

Models and training intermediate data are to be found in your host directory. 

Subdirectory `models/` contains the generated model `output_graph.pb`. However, such a file needs to be loaded in memory when running inference. 

Therefore, additional models in tflite format, to be run on mobile devices, and mmap-able format, to read data directly from disk, are generated as well. 

Training intermediate data are kept in `checkpoints/` subdirectory. The purpose of checkpoints is to allow interruption and later resume training.

For further information, be pleased to consult [DeepSpeech Documentation](https://deepspeech.readthedocs.io/en/v0.8.2).