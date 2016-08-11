{:user
 {:plugins [[lein-exec "0.3.5"]
            [lein-try "0.4.3"]
            [cider/cider-nrepl "0.9.0-SNAPSHOT"]
            [lein-localrepo "0.5.3"]]
  :dependencies [[leiningen #=(leiningen.core.main/leiningen-version)]
                 [im.chit/vinyasa "0.4.2"]]
  :injections [(require '[vinyasa.inject :as inject])
               (inject/in
                [vinyasa.inject :refer [inject [in inject-in]]]
                [vinyasa.reimport :refer [reimport]]
                [vinyasa.lein :exclude [*project*]])]
  :mirrors      {"central" {:url "https://repo1.maven.org/maven2/"}}}}
