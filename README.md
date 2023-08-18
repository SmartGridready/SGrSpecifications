# SGrSpecifications
Contains the schema, functional profiles and external interface descriptions for SmartgridReady.

License see LICENSE file

## Vision
To reach the gobal climate goals energy production from renewable sources will gain an increased share. But
renewables can be erratic and less predictable in production. On the consumer side energy consumption will increase
with a growing number of installed heat pumps and EV charging stations. Keeping a balanced energy grid will therefore
become more challenging. But there is a solution!

Even at individual building level we can often shift energy consumption through energy and load management. Peaks of
overproduction as well as overconsumption can be dampened.

SmartGridready helps in describing exsiting functionality of energy-related devices, allowing innovative solutions on the
path to a smart energy grid.

SmarGridready is
- open, technology neutral, and non-proprietary
- maintained and extended by product & communicator manufacturer, users and the companies of the energy market
- compliant to existing standards

## Architecture
SmartGridready introduces two roles: products and communicators. Products typically either produce or consume energy.
Communicators are controlling the behaviour of products. Note that SmartGridready allows for cascaded architectures. A
Consumer Energy Manager (CEM), installed in your house, can act as a communicator towards typical house instalations
(heat pumps, EV charging stations, potovoltaic installations, ...) and be a product towards the distribution grid (e.g.
offering services for flexible load mangement).

![SmartGridready architecture](doc/architecture.png)

## Buiding Blocks
| Block | Description |
|-------|-------------|
| [External Interface Description](doc/externalInterface.md) | A machine- and human-readable description of the products communication interface. |
| [Functional Profile](doc/functionalProfile.md) | A set of use-case related datapoints (read or write) offered by the product. |
| Communicator Description | A machine- and human-readable description of the communicators capabilities |

Every building block is described through a common [XML schema](doc/SGrSchema.md).

## Visualization

The external interface XML and funcitonal profile XMLs are visuzalized through XSLT. 
See https://library.smartgridready.ch.

## Processes
This repository contains the XML schema, as well as the device description XMLs and functional profile XMLs.
Any changes on XML files of this repository are pushed through gitub actions to the SGr Library.
