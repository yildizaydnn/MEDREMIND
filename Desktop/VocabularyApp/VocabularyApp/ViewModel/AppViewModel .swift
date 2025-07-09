import Foundation
import Combine

// MARK: - AppViewModel
// Uygulamanın ana ViewModel'ı. İş mantığını diğer yöneticilere devreder.
class AppViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var progressManager: ProgressManager
    @Published var wordManager: WordManager

    // Combine aboneliklerini tutmak için Set
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    init() {
       
        let wm = WordManager()
        let pm = ProgressManager(allLevels: wm.allLevels)

    
        self.wordManager = wm
        self.progressManager = pm

      
        self.wordManager.updateCurrentWordsForLearning(forLevel: pm.userProgress.currentLevel)

      
        pm.$userProgress
            .map { $0.currentLevel }
            .removeDuplicates()
            .sink { [weak self] newLevel in
                self?.wordManager.updateCurrentWordsForLearning(forLevel: newLevel)
            }
            .store(in: &cancellables)
    }

    
    // MARK: - Public Helper Properties (Opsiyonel, kolay erişim için)
    var currentLevel: Int {
        progressManager.userProgress.currentLevel
    }
    
    var completedDays: Int {
        progressManager.userProgress.completedDays
    }
    
    var currentWordsForLearning: [Word] {
        wordManager.currentWordsForLearning
    }
    
    var savedWords: [Word] {
        progressManager.userProgress.saveWords
    }
    
    // MARK: - Public Methods (Sadece yönetici fonksiyonlarına yönlendirmeler)
    func completeDay() {
        progressManager.completeDay()
    }
    
    func addWordToSavedWords(_ word: Word) {
        progressManager.addWordToSaveWords(word)
    }
    
    func removeWordFromSavedWords(_ word: Word) {
        progressManager.removeWordFromSaveWords(word)
    }
    
    func resetProgress() {
        progressManager.resetProgress()
    }
}
