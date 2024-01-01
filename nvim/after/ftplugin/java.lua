
-- ╭──────────────────────────────────────────────────────────╮
-- │                NVIM-JDTLS CONFIGURATION                  │
-- ╰──────────────────────────────────────────────────────────╯
-- Java Language Server configuration.
-- Locations:
-- 'nvim/ftplugin/java.lua'.
-- 'nvim/lang-servers/intellij-java-google-style.xml'

local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
  return
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local jdtls_path = vim.fn.stdpath('data') .. "\\mason\\packages\\jdtls"                                     -- jdtls_path = "C:\Users\<user_name>\AppData\Local\nvim-data\msaon\packages\jdtls"
local path_to_config = jdtls_path .. "\\config_win"                                                         -- path_to_config --> "C:\Users\dghuu\AppData\Local\nvim-data\mason\packages\jdtls\config_win"
local path_to_plugins = jdtls_path .. "\\plugins\\"                                                         -- path_to_plugins --> "C:\Users\dghuu\AppData\Local\nvim-data\mason\packages\jdtls\plugins\"
local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar"            -- path_to_jar --> "C:\Users\dghuu\AppData\Local\nvim-data\mason\packages\jdtls\plugins\org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar"
local lombok_path = path_to_plugins .. "lombok.jar"

--  local function capabilities()
	--  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	--  if status_ok then
		--  return cmp_nvim_lsp.default_capabilities()
	--  end

	--  local capabilities = vim.lsp.protocol.make_client_capabilities()
	--  capabilities.textDocument.completion.completionItem.snippetSupport = true
	--  capabilities.textDocument.completion.completionItem.resolveSupport = {
		--  properties = {
			--  "documentation",
			--  "detail",
			--  "additionalTextEdits",
		--  },
	--  }

	--  return capabilities
--  end

local function directory_exists(path)
	local f = io.popen("cd " .. path)
	local ff = f:read("*all")

	if ff:find("ItemNotFoundException") then
		return false
	else
		return true
	end
end

-- calculate workspace dir
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name                          -- workspace_dir = "C:\Users\dghuu\AppData\Local\nvim-data/site/java/workspace-root/JavaCode"

if directory_exists(workspace_dir) then
else
	os.execute("mkdir " .. workspace_dir)
end

-- get the mason install path
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()                                -- install_path = "C:\Users\dghuu\AppData\Local\nvim-data\mason\packages\jdtls"

-- get the current OS
local os
if vim.fn.has("macunix") == 1 then
  os = "mac"
elseif vim.fn.has("linux") == 1 then
  os = "linux"
elseif vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
  os = "win"
end

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")                                                             -- mason_path = "C:\Users\dghuu\AppData\Local\nvim-data\mason\"
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n"))

local config = {
	cmd = {
		"C:/Program Files/Java/jdk-19/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. install_path .. "/lombok.jar",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),             -- C:\Users\dghuu\AppData\Local\nvim-data\mason\packages\jdtls\plugins\org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar
		"-configuration",
		install_path .. "/config_" .. os,
		"-data",
		workspace_dir,
	},
	--  capabilities = capabilities(),

	root_dir = root_dir,
	settings = {
		java = {
      home = 'C:/Program Files/Java/jdk-19',
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-19",
            path = "C:/Program Files/Java/jdk-19",
          },
          {
            name = "JavaSE-17",
            path = "C:/Program Files/Java/jdk-17",
          }
        }
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
    },

    signatureHelp = { enabled = true },

    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },

    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },

	},

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
		bundles = {
			vim.fn.glob(
				mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
				"\n"
			),
		},
	},
}

--  config['on_attach'] = function(client, bufnr)
  --  --  require('keymaps').map_java_keys(bufnr);
  --  require("lsp_signature").on_attach({
    --  bind = true, -- This is mandatory, otherwise border config won't get registered.
    --  floating_window_above_cur_line = false,
    --  padding = '',
    --  handler_opts = {
      --  border = "rounded"
    --  }
  --  }, bufnr)
--  end

config["on_attach"] = function(client, bufnr)
	local _, _ = pcall(vim.lsp.codelens.refresh)
	require("jdtls.dap").setup_dap_main_class_configs()
	jdtls.setup_dap({ hotcodereplace = "auto" })
	require("user.lsp.handlers").on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  print("Calling java server... "),
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
})

-- Main service loading...!
jdtls.start_or_attach(config)

vim.cmd(
	[[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
)
