SHELL := /bin/bash
PROTO_PACKAGE_NAMES = auth
PROTO_SRC_DIR= .
GENERATED_DIR ?= ./generated

#function to generate go bindinds
define generate_protos_go
	@for pkg in $(1); do \
		echo "Protos will be generated in dir $(2) " ; \
		echo "Source Dir is $(3) " ; \
		echo "Making Dir $(2)/$${pkg}... " ; \
		mkdir -p $(2)/$${pkg} ; \
		echo "Generating Go bindings for $${pkg}... " ; \
		protoc \
		--go_out=$(2)/$${pkg} \
		--go_opt=paths=source_relative \
		--go-grpc_out=$(2)/$${pkg} \
		--go-grpc_opt=paths=source_relative \
		--proto_path=$(3)/$${pkg}/ \
		$(3)/$${pkg}/*.proto ; \
	done
endef

.PHONY: generate-protos

generate-protos:
	$(call generate_protos_go,$(PROTO_PACKAGE_NAMES),$(GENERATED_DIR),$(PROTO_SRC_DIR))

.PHONY: clean

clean:
	rm -rf $(GENERATED_DIR)