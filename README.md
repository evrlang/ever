
<img src="docs/everlogo.jpg" height="100" width="100"/>
</center>

## Quick Install (Linux/macOS)

```bash
curl -sL https://raw.githubusercontent.com/evrlang/ever/main/install.sh | bash
```
> Make sure to read [this](docs/windows-development.md) before running the Windows version of Ever.

<h1 style="font-weight:bold;"> Ever Programming Language</h1>

<h1 style="font-weight:bold;">Why Ever?</h1>
We all love C, but at the same time, it's difficult to use in projects and working with pointers makes many people die when writing it. But the goal of ever is almost the same. Basically, ever wants to have a simple and functional syntax like Turbo C, easy to understand and work with, but in a modern environment.
<h1>Current status</h1>
well, right now the project is in alpha mode. That means it's only released for debugging and it's full of bugs! And it's fixing problems and testing new features. So it's not suitable for use and it's not predictable to some extent. And it's more educational than industrial.
<h1>Examples</h1>
ever is easy and really human-friendly. It's very easy to read and it depends on how well or how busy you are at coding.
<p>print hello world </p>
<pre><code>
def:write "Hello world\n"
</pre></code>
<p>print hello world and add strings to themself</p>
<pre><code>
def:write ("Hello World" + "\n")
</pre></code>
<p>get input from user and check if it equal to a value</p>
<pre><code>
gen string @name def:getInput "Whats your name? "
if (@name == "ever")
	def:write (@BOLD + @GREEN + "Hello world" + "\n")
end
</pre></code>
<p>create a timer then it tick every 3500ms, in first tick we show a message</p>
<pre><code>
_time 3500
delegate tick
	def:write ("@RED" + "Hello" + @RESET)
end
</code></pre>

# Compile

To compile Ever, you first need `gcc`, `make`, `dmd` (D Compiler), and `dub` installed on your computer.

> **Note:** Compilation may have linker problems on Windows. I tested it on Windows 7, and it did not work.

Download the source code from the releases and unzip it.

Then, go to the `evrlib` folder using `cd` and run:

```bash
make
```

After that, copy `libcbased.so` to `/usr/local/lib` so the linker can find it easily:

```bash
sudo cp libcbased.so /usr/local/lib/
```

Then run:

```bash
sudo ldconfig
```

This updates the system's shared-library cache.

Now, go to the `src` folder inside the Ever source directory and run:

```bash
dub build
```

> **Tip:** If you want to compile without debug symbols and reduce the binary size, use:
> 
> ```bash
> dub build --build=release
> ```


### Continue With [Getting Started](docs/GETSTART.md)
