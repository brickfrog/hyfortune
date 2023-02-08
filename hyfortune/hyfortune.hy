(import datetime [datetime]
        json
        os
        random
        shutil
        os.path [expanduser])

(import rich.align [Align]
        rich.console [Console]
        rich.markdown [Markdown]
        rich.rule [Rule]
        rich.table [Table])

(setv console (Console))

(defn center-print [text [style None] [wrap False]]
  (let [width (if wrap
              (// (get (shutil.get_terminal_size) 0) 2)
              (get (shutil.get_terminal_size) 0))]
  (console.print (Align.center text :style style :width width))
  ))

(defn write-config [data]
  (with-open [of (open (os.path.join config-path "config.json") "w")]
    (.write of (json/dumps data :indent 2))))

(defn getquotes []
  (let [__location__ (os.path.realpath (os.path.join (os.getcwd) (os.path.dirname __file__)))
        quotes-file (with [qf (open (os.path.join __location__ "quotes.json") "r")]
                      (json.load qf))]
    (get quotes-file (random.randint 0 500))))

(defn main []
  (setv config-path (os.path.join (os.path.expanduser "~") ".config" "please"))
  (with [configfile (open (os.path.join config-path "config.json"))]
      (setv config (json.load configfile))
  (let [date-now (datetime.now)
         user-name (get config "user_name")
         quote_content (getquotes)
         quote_content_content (quote_content.get "content" None)
         quote_content_author (quote_content.get "author" None)
         formatted_date (date_now.strftime "%d %b | %I:%M %p")]
    (console.rule f"[#FFBF00] Hello {user_name}! It's {formatted_date}\n")
    (center-print f"\n[#63D2FF]{quote_content_content}\n" "bold" True)
    (center-print f"[#63D2FF] - {quote_content_author}" "bold" True)

    )))

(main)