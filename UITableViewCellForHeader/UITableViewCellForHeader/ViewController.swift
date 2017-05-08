//
//  ViewController.swift
//  UITableViewCellForHeader
//
//  Created by RTC-HN158 on 5/8/17.
//  Copyright © 2017 NhatHM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listBookTable: UITableView!
    
    var listBook: [String: [(String, String, Bool)]] = [:]
    var listYears: [String] = []
    var lastSelectedBook: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.listBookTable.rowHeight = UITableViewAutomaticDimension
        self.listBookTable.estimatedRowHeight = 100
        
        self.listBook = [
            "2000": [
                ("The Corrections by Jonathan Franzen", "The Corrections is a 2001 novel by American author Jonathan Franzen. It revolves around the troubles of an elderly Midwestern couple and their three adult children, tracing their lives from the mid...", false),
                ("Atonement by Ian McEwan", "Atonement is a 2001 novel by British author Ian McEwan. It tells the story of protagonist Briony Tallis's crime and how it changes her life, as well as those of her sister Cecilia and her lover Rob...", false),
                ("White Teeth by Zadie Smith", "This may be the first novel ever written that truly feels at home in our borderless, globalized, intermarried, post-colonial age, populated by children with first and last names on a direct collis...", false),
                ("Austerlitz by W. G. Sebald", "Austerlitz, the internationally acclaimed masterpiece by \"one of the most gripping writers imaginable\" (The New York Review of Books), is the story of a man?s search for the answer to his life?s ce...", false),
                ("The Amazing Adventures of Kavalier and Clay by Michael Chabon", "The Amazing Adventures of Kavalier & Clay is a 2000 novel by American author Michael Chabon that won the Pulitzer Prize for Fiction in 2001. The novel follows the lives of the title characters, a C...", false)
            ],
            "1990": [
                ("American Pastoral by Philip Roth", "American Pastoral is a Philip Roth novel concerning Seymour \"Swede\" Levov, a Jewish-American businessman and former high school athlete from Newark, New Jersey. Levov's happy and conventional upper...", false),
                ("The Wind-Up Bird Chronicle by Haruki Murakami", "The Wind-Up Bird Chronicle (ねじまき鳥クロニクル, Nejimaki-dori Kuronikuru?) is a novel by Haruki Murakami. The first published translation was by Alfred Birnbaum. The American translation and its British ad...", false),
                ("Harry Potter And The Philosopher's Stone by J. K. Rowling", "Harry Potter and the Philosopher's Stone is the first novel in the Harry Potter series written by J. K. Rowling and featuring Harry Potter, a young wizard. It describes how Harry discovers he is a ...", false),
                ("The Corrections by Jonathan Franzen", "The Corrections is a 2001 novel by American author Jonathan Franzen. It revolves around the troubles of an elderly Midwestern couple and their three adult children, tracing their lives from the mid...", false),
                ("Atonement by Ian McEwan", "Atonement is a 2001 novel by British author Ian McEwan. It tells the story of protagonist Briony Tallis's crime and how it changes her life, as well as those of her sister Cecilia and her lover Rob...", false)
            ]
        ]
        
        self.listYears = Array(self.listBook.keys)
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listBook.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listBook[self.listYears[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as!  HeaderCell
        headerView.title.text = "The Greatest Books Since \(self.listYears[section])"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        
        // Configure the cell...
        var listBookForYear: [(String, String, Bool)] = self.listBook[self.listYears[indexPath.section]]!
        let book: (String, String, Bool) = listBookForYear[indexPath.row]
        cell.title.text = book.0
        if book.2 == true {
            cell.content.text = book.1
        } else {
            cell.content.text = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var listBookForYear: [(String, String, Bool)] = self.listBook[self.listYears[indexPath.section]]!
        var selectedBook: (String, String, Bool) = listBookForYear[indexPath.row]
        selectedBook.2 = !selectedBook.2
        listBookForYear[indexPath.row] = selectedBook
        self.listBook[self.listYears[indexPath.section]] = listBookForYear
        
        self.listBookTable.beginUpdates()
        self.listBookTable.reloadRows(at: [indexPath], with: .automatic)

        if self.lastSelectedBook == nil {
            self.lastSelectedBook = indexPath
        } else if self.lastSelectedBook !=  indexPath {
            listBookForYear = self.listBook[self.listYears[self.lastSelectedBook!.section]]!
            var lastSelectedBook: (String, String, Bool) = listBookForYear[self.lastSelectedBook!.row]
            lastSelectedBook.2 = !lastSelectedBook.2
            
            listBookForYear[self.lastSelectedBook!.row] = lastSelectedBook
            self.listBook[self.listYears[self.lastSelectedBook!.section]] = listBookForYear
            self.listBookTable.reloadRows(at: [self.lastSelectedBook!], with: .automatic)
            self.lastSelectedBook = indexPath
        } else {
            self.lastSelectedBook = nil
        }
        
        self.listBookTable.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

