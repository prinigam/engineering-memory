require "dotenv/load"
require_relative "../lib/jira_client"

client = JiraClient.new

context = client.context("FINI-2044")

pp context