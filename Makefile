# CAR_OCI_REGISTRY_USER  and PROJECT are combined to define the Docker
# tag for this project. The definition below inherits the standard
# value for CAR_OCI_REGISTRY_USER  (=artefact.skao.int) and overwrites
# PROJECT to give a final Docker tag of artefact.skao.int/ska-tmc-cdm
#
CAR_OCI_REGISTRY_HOST ?= artefact.skao.int
CAR_OCI_REGISTRY_USERNAME ?= ska-telescope
PROJECT_NAME = ska-low-integration
KUBE_APP ?= ska-low-integration
KUBE_NAMESPACE ?= ska-low-integration
KUBE_NAMESPACE_SDP ?= $(KUBE_NAMESPACE)-sdp
HELM_CHART ?= ska-low-integration
UMBRELLA_CHART_PATH ?= charts/$(HELM_CHART)/
RELEASE_NAME = $(HELM_CHART)
SDP_SIMULATION_ENABLED ?= true
CSP_SIMULATION_ENABLED ?= true
MCCS_SIMULATION_ENABLED ?= true
CI_PROJECT_DIR ?= .
SDP_DEPLOY ?= true
MINIKUBE ?= false ## Minikube or not
EXPOSE_All_DS ?= true ## Expose All Tango Services to the external network (enable Loadbalancer service)
SKA_TANGO_OPERATOR ?= true
ODA_URI ?= http://ska-db-oda-rest-$(HELM_RELEASE).$(KUBE_NAMESPACE).svc.$(CLUSTER_DOMAIN):5000/$(KUBE_NAMESPACE)/api/v1

NOTEBOOK_IGNORE_FILES = not notebook.ipynb

OCI_IMAGE_BUILD_CONTEXT = $(PWD)
CI_JOB_ID ?= local##pipeline job id
TANGO_HOST ?= tango-databaseds:10000## TANGO_HOST connection to the Tango DS
TANGO_SERVER_PORT ?= 45450## TANGO_SERVER_PORT - fixed listening port for local server
CLUSTER_DOMAIN ?= cluster.local## Domain used for naming Tango Device Servers
K8S_TEST_RUNNER = test-runner-$(CI_JOB_ID)##name of the pod running the k8s-test
TARANTA_AUTH_DASHBOARD_ENABLE ?= false
# Single image in root of project
OCI_IMAGES = ska-low-integration
PORT ?= 10000
ITANGO_ENABLED ?= true
#TANGO_HOST_NAME ?= tango-databaseds  #derived in EDA configuration below
HELM_CHARTS_TO_PUBLISH = $(HELM_CHART)
HELM_CHARTS ?= $(HELM_CHARTS_TO_PUBLISH)
K8S_EXTRA_PARAMS ?= 
SDP_MASTER ?= tango://$(TANGO_HOST_NAME).$(KUBE_NAMESPACE).svc.$(CLUSTER_DOMAIN):$(PORT)/low-sdp/control/0
SDP_SUBARRAY_PREFIX ?= tango://$(TANGO_HOST_NAME).$(KUBE_NAMESPACE).svc.$(CLUSTER_DOMAIN):$(PORT)/low-sdp/subarray

#EDA configuration
ARCHIVER_PWD ?=  #this is read from the pipeline
ARCHWIZARD_VIEW_DBNAME = low_sw_int_eda
TANGO_HOST_NAME?= $(shell echo $(TANGO_HOST) | cut -d ":" -f 1)
ARCHIVER_HOSTNAME ?= #set from pipeline
CONFIG_MANAGER = low-eda/cm/01
ARCHWIZARD_CONFIG = $(ARCHWIZARD_VIEW_DBNAME)=tango://$(TANGO_HOST_NAME).$(KUBE_NAMESPACE).svc.$(CLUSTER_DOMAIN):10000/$(CONFIG_MANAGER)
ARCHIVER_TIMESCALE_DB_USER = admin

# disable convention and refactoring lint warnings
PYTHON_SWITCHES_FOR_PYLINT += --disable=C,R,W0612,E0401,W0611,W0105

# resolve various conflicts with Black formatting
PYTHON_SWITCHES_FOR_FLAKE8 += --extend-ignore=E501,W291,W503,F401,E402,F541,F704,F841

# include OCI Images support
include .make/oci.mk

# include k8s support
include .make/k8s.mk

# include Helm Chart support
include .make/helm.mk

# Include Python support
include .make/python.mk

# include raw support
include .make/raw.mk

# include core make support
include .make/base.mk

# include your own private variables for custom deployment configuration
-include PrivateRules.mak

# Chart for testing
K8S_CHART = $(HELM_CHART)
K8S_CHARTS = $(K8S_CHART)

ifeq ($(SDP_SIMULATION_ENABLED),false)
K8S_EXTRA_PARAMS =	-f charts/ska-low-integration/tmc_pairwise/tmc_sdp_values.yaml \
	--set global.sdp_master=$(SDP_MASTER)\
	--set global.sdp_subarray_prefix=$(SDP_SUBARRAY_PREFIX)
endif

ifeq ($(CSP_SIMULATION_ENABLED),false)
K8S_EXTRA_PARAMS =	-f charts/ska-low-integration/tmc_pairwise/tmc_csp_values.yaml
endif

ifeq ($(MCCS_SIMULATION_ENABLED),false)
K8S_EXTRA_PARAMS =	-f charts/ska-low-integration/tmc_pairwise/tmc_mccs_values.yaml
endif


K8S_CHART_PARAMS = --set global.minikube=$(MINIKUBE) \
	--set global.exposeAllDS=$(EXPOSE_All_DS) \
	--set global.tango_host=$(TANGO_HOST) \
	--set global.cluster_domain=$(CLUSTER_DOMAIN) \
	--set global.device_server_port=$(TANGO_SERVER_PORT) \
	--set global.operator=$(SKA_TANGO_OPERATOR) \
	--set global.sdp.processingNamespace=$(KUBE_NAMESPACE_SDP) \
	--set ska-tango-base.itango.enabled=$(ITANGO_ENABLED) \
	--set ska-sdp.kafka.zookeeper.clusterDomain=$(CLUSTER_DOMAIN) \
	--set ska-sdp.kafka.clusterDomain=$(CLUSTER_DOMAIN) \
	--set ska-sdp.ska-sdp-qa.redis.clusterDomain=$(CLUSTER_DOMAIN) \
	--set ska-oso-oet.rest.ingress.enabled=$(OET_INGRESS_ENABLED) \
	--set ska-oso-oet.rest.oda.url=$(ODA_URI) \
	--set ska-db-oda.rest.backend.type=filesystem \
	--set ska-db-oda.pgadmin4.enabled=false \
	--set ska-db-oda.postgresql.enabled=false \
	--set ska-tango-archiver.dbpassword=$(ARCHIVER_PWD)\
	--set ska-tango-archiver.hostname=$(ARCHIVER_HOSTNAME)\
	--set ska-tango-archiver.archwizard_config=$(ARCHWIZARD_CONFIG)\
	$(K8S_EXTRA_PARAMS)


# ifeq ($(strip $(MINIKUBE)),true)
# ifeq ($(strip $(TARANTA_AUTH_DASHBOARD_ENABLE)),true)
# K8S_CHART_PARAMS += \
# 	--set ska-taranta.enabled=true \
# 	--set ska-taranta.tangogql.replicas=1 \
# 	--set global.taranta_auth_enabled=true \
# 	--set global.taranta_dashboard_enabled=true
# else
# K8S_CHART_PARAMS += --set ska-taranta.enabled=false
# endif
# else
# K8S_CHART_PARAMS += --set ska-taranta.enabled=true
# ifeq ($(strip $(TARANTA_AUTH_DASHBOARD_ENABLE)),true)
# K8S_CHART_PARAMS += \
# 	--set global.taranta_auth_enabled=true \
# 	--set global.taranta_dashboard_enabled=true
# endif
# endif

# to create SDP namespace
k8s-pre-install-chart:
ifeq ($(SDP_DEPLOY),true)
	@echo "k8s-pre-install-chart: creating the SDP namespace $(KUBE_NAMESPACE_SDP)"
	@make k8s-namespace KUBE_NAMESPACE=$(KUBE_NAMESPACE_SDP)
endif

# to create SDP namespace
k8s-pre-install-chart-car:
ifeq ($(SDP_DEPLOY),true)
	@echo "k8s-pre-install-chart-car: creating the SDP namespace $(KUBE_NAMESPACE_SDP)"
	@make k8s-namespace KUBE_NAMESPACE=$(KUBE_NAMESPACE_SDP)
endif
# to delete SDP namespace
k8s-post-uninstall-chart:
ifeq ($(SDP_DEPLOY),true)
	@echo "k8s-post-uninstall-chart: deleting the SDP namespace $(KUBE_NAMESPACE_SDP)"
	@make k8s-delete-namespace KUBE_NAMESPACE=$(KUBE_NAMESPACE_SDP)
endif
