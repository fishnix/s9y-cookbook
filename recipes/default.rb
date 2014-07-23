#
# Cookbook Name:: s9y
# Recipe:: default
#
# Copyright 2011, E Camden Fisher
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "s9y::prep"
include_recipe "s9y::php"
include_recipe "s9y::framework"
include_recipe "s9y::plugins"
include_recipe "s9y::templates"
include_recipe "s9y::apache2"
include_recipe "s9y::db"
